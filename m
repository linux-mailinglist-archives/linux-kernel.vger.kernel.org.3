Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390894CAEED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiCBTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbiCBTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:43:38 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 11:42:54 PST
Received: from post.munsonfam.org (post.munsonfam.org [172.104.17.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC549900;
        Wed,  2 Mar 2022 11:42:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at munsonfam.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=munsonfam.org;
        s=20211029; t=1646249771;
        bh=VYngCzG9clONeml2uhaUgxir5/zqo7l4bZiFQxv/mJw=;
        h=Date:From:To:Cc:Subject:From;
        b=d7weWaD9aYfYX+hpYssOLvnts5zSF9XLIPLIBHbbTGiu8hcIiq6J6vfcrXROyvwFZ
         GdaOrQNawSpbQtLXrJQLs0VtY0kqVCxnV3b0qwRaLIWETSQhV51szftz1pay1kAQ0R
         mzqZfoc3KC1N5EEHEM3Zr6ps2aanAgCXEm1+Rno617k5hKtx0gsr+scvsjMCPtok0k
         Thn75O8gztSiKpcmh4A6B8bOVlFYOKMrTtrPoPVeFPM1XwXDK83YJnkUdksvhPJ5vv
         IOkJ/gkf4HteAKUlhtVwPPoIHkVBSC0TdThLvgdE9ixapRK028KXUYyPngg/od8kBW
         k0RaNBiaIScUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=munsonfam.org;
 s=20211029; t=1646249771;
 bh=VYngCzG9clONeml2uhaUgxir5/zqo7l4bZiFQxv/mJw=;
 h=Date:From:To:Cc:Subject:From;
 b=d7weWaD9aYfYX+hpYssOLvnts5zSF9XLIPLIBHbbTGiu8hcIiq6J6vfcrXROyvwFZ
 GdaOrQNawSpbQtLXrJQLs0VtY0kqVCxnV3b0qwRaLIWETSQhV51szftz1pay1kAQ0R
 mzqZfoc3KC1N5EEHEM3Zr6ps2aanAgCXEm1+Rno617k5hKtx0gsr+scvsjMCPtok0k
 Thn75O8gztSiKpcmh4A6B8bOVlFYOKMrTtrPoPVeFPM1XwXDK83YJnkUdksvhPJ5vv
 IOkJ/gkf4HteAKUlhtVwPPoIHkVBSC0TdThLvgdE9ixapRK028KXUYyPngg/od8kBW
 k0RaNBiaIScUQ==
Received: by lappy-486.munsonfam.org (Postfix, from userid 1000)
 id 7E7639E0237; Wed,  2 Mar 2022 14:36:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=munsonfam.org;
 s=20211029; t=1646249771;
 bh=VYngCzG9clONeml2uhaUgxir5/zqo7l4bZiFQxv/mJw=;
 h=Date:From:To:Cc:Subject:From;
 b=d7weWaD9aYfYX+hpYssOLvnts5zSF9XLIPLIBHbbTGiu8hcIiq6J6vfcrXROyvwFZ
 GdaOrQNawSpbQtLXrJQLs0VtY0kqVCxnV3b0qwRaLIWETSQhV51szftz1pay1kAQ0R
 mzqZfoc3KC1N5EEHEM3Zr6ps2aanAgCXEm1+Rno617k5hKtx0gsr+scvsjMCPtok0k
 Thn75O8gztSiKpcmh4A6B8bOVlFYOKMrTtrPoPVeFPM1XwXDK83YJnkUdksvhPJ5vv
 IOkJ/gkf4HteAKUlhtVwPPoIHkVBSC0TdThLvgdE9ixapRK028KXUYyPngg/od8kBW
 k0RaNBiaIScUQ==
Date:   Wed, 2 Mar 2022 14:36:09 -0500
From:   Eric B Munson <eric@munsonfam.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Problem: Bluetooth stops connecting to paired devices after commit
 6a98e3836fa207
Message-ID: <Yh/HKSW05IfXCGbR@munsonfam.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yoqJaS6jdXW3GHEp"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yoqJaS6jdXW3GHEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When testing the latest upstream this morning, my bluetooth mouse
stopped working. Further inspection showed that my laptop is failing to
connect, but I didn't see anything relevant in dmesg, the driver seemed
to load firmware and intialize fine.

A bisect turned up commit 6a98e3836fa207 as the first bad one, but
unfortunately there was another problem discovered during the bisect
where my bluetooth radio failed to come up at all.

I am using a 5 year old Lenovo X1 carbon which is using the Intel
Wireless 8265 / 8275 card and the btintel driver.

I can easily reproduce, and would be happy to test patches or help
diagnose if I can. Is this a known issue?

Regards,
Eric

--yoqJaS6jdXW3GHEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ71cx3bfGX4kMtFBqEb2cZzVukkFAmIfxxUACgkQqEb2cZzV
uknIPA/7BUlzuhCHYlHrnxQ+K2//zZaX5M6MkKNGiD3qWu1/l7IoNb0MyscPbWj3
wJHqYtvWAbBUEm3gxjOtnS0pCK8emoap/SCYagFUzl7llwCxxZ2nvRqc+m5Revq0
iKxFa8Yh2TNN21rC8CLyb7NCvZO8XAObxptu23CCLHjbTT41bxvwVuyzg9HeOsVT
XTOII31i0pEVDoVkg7ToOIRtg73b7bWi14WYBlRcoORy5olWdmkc0OOfMYa6kd5f
OzbwOIyIv4PsSD4U9vkxU0vp2lTd6qP1zKi6hbya33MqWRFlLarbmBQYo9Ti8pnR
PmeyvUkylTjxbxQ6hC5gYQd1+5oDupWpyAg03ApRbbsUqZtfOPTYEheTZv0DLMW/
lf7teBR8zP/C5UHrk5rafu0DBOSSBE5DOZwm8NL/9GkMOcGxpKsGFXy4uUKsPC1/
dlUazoXreo4g9zm4yO9FdtX4Eu2C2pdLlvdoYs2tIj1p6N5nYUbWOycgRz5ykNYV
WYoZCa82P0vLPxybdPcGrygSMU+xZo0DuXjApm8f+XZ3xaajl9cANU08qQlFqRu8
gdpdR3HogsvDzqTr10Fs9wjES1DL0kJzPnDnqJmB4DbBIAqbYapcI0G+WWGdhZT5
DaioWdQBqLp5jmLYwoC4mi8F0O7F5lhhKQzASbO0b34TTW40nbs=
=g4kZ
-----END PGP SIGNATURE-----

--yoqJaS6jdXW3GHEp--
