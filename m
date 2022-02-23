Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436FC4C1101
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiBWLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiBWLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:08:25 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537F8EB5B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:07:57 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 515D95F929;
        Wed, 23 Feb 2022 12:07:55 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: atc260x has broken locking
Date:   Wed, 23 Feb 2022 12:07:48 +0100
Message-ID: <16136311.TfV2VxeR0u@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1905280.viRWdgczpX"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1905280.viRWdgczpX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: atc260x has broken locking
Date: Wed, 23 Feb 2022 12:07:48 +0100
Message-ID: <16136311.TfV2VxeR0u@mobilepool36.emlix.com>

When looking at this functions I found the locking to be broken for the ato=
mic=20
case (comments stripped):

static void regmap_lock_mutex(void *__mutex)
{
	struct mutex *mutex =3D __mutex;

	if (system_state > SYSTEM_RUNNING && irqs_disabled())
		mutex_trylock(mutex);
	else
		mutex_lock(mutex);
}

static void regmap_unlock_mutex(void *__mutex)
{
	struct mutex *mutex =3D __mutex;

	mutex_unlock(mutex);
}

When the mutex is already locked and the atomic context is hit then the loc=
k=20
will not be acquired, this is never noticed, and it afterwards is unlocked=
=20
anyway.

The comment says this is inspired from i2c_in_atomic_xfer_mode() to detect =
the=20
atomic case, but the important caller __i2c_lock_bus_helper() actually does=
=20
check and pass on the return value of mutex_trylock(), which is missing her=
e.

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1905280.viRWdgczpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYhYVhAAKCRCr5FH7Xu2t
/J+7A/9yyYI6rtw0seE6T+brf2gPxfT8AN1cR6NhpG1fer66+7sZDFPD8Fcohnm1
3kNuHFnOPbArlvbqJES+XRM9l6EUcnHmZYaqwB7bGg+KkzGhAr24qdWdrchhEY/3
mapEPHpRYwIgYsudF/OEcSukQdDpdhrVFckr2GQUGdNIQ5KVoQ==
=2r1T
-----END PGP SIGNATURE-----

--nextPart1905280.viRWdgczpX--



