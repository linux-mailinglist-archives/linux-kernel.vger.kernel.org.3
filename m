Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECB4B5045
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351447AbiBNMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBNMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:33:55 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 04:33:47 PST
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3B4A3C7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644842026;
        bh=84k/EoVoWVAY9EFEJhZ3x3GPR9+cYp7/R0Zz+rHzqRo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=qXOIK4nQ227c39gJsGYurMhbGuw1IMPFS7I/Ccv8TUM46LWPI9JAMO1bP36OwrRi1
         2SZoclqZnvj1hCfEKI/qJDWo6byxhKI0N9tXkHr6YebEsaTs5FJ9x7VFCgsrnOFVfL
         /RQID3QThHvj+V3UY7k0UMdx/r+mHIrHVF0efZcA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from schienar ([128.141.229.125]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mae3q-1nqA4D3gvi-00cKam; Mon, 14
 Feb 2022 13:28:39 +0100
Date:   Mon, 14 Feb 2022 13:28:38 +0100
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>
Subject: v5.17.0-rc3: Regression bisecting failing suspend to disk: ALSA:
 hda: realtek: Fix race at concurrent COEF updates
Message-ID: <20220214132838.4db10fca@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ycVXxNClGrKE24vzcWsZdYakcruvmxhRhlYCy3dNncpUIRCwfa3
 k0l9dwXqGvApiNMFrLkaFBnMNOsa+RXME1BroVfyYgcILDnsQ+rqz6rnzBPoiZcEdiY9wef
 hC2dDASEhPueVTzk0v+A8WH111FnQ10rP4Xn8tXhxBur9jG45vRD6hLS35Sj3j1PR+3wqQ/
 soldAHPJFupZy8rszUnqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vK5QEthO3RQ=:zlSvmHovXF6fHHRppF9Cn4
 gx8ljHsir0Iiu8xF1BB+3Rgcs+Iu6THfFsD0tgZawzutIL8Z8b2raDztvKlX0mytd/CHpftMt
 fCDi7aJ/ADz1+LLN9ozBDXf6+e6Yv6cXqSz2c2+DgA8punujKc/s2EG2e1F5n3Xpc2d6hXmmw
 7ZTTDkV69hR1n2EsDtEZP9xC5+eLQcFchaffgw6/huDNSJZle2jY6LuST2Ww6FnIgnzxpOspf
 w69XUg4FGQA43hdQpa+KXX+eft98H1+ELouOXwi0scRVm+vJ3Pk9Ou03xlrn/atNfe+RtV1d/
 EYfb0suFtF4y3n5LvgYgWX+ovp++KJxBJsHfQJncgLJg76EzbLhVWCzx7cPFAh6bdrk0BmmxM
 qRbeh+tGBHR7jSnD2cMeAdmXLmCy8oS1bL9whefcWlWBSOCu8am2r5WxAGhGQzQhsDnIBRhkL
 k3ib8UZv26QoMlg2I5GnzhohqljEIc47v8NikXm3Z91DF8jm4Q6Wyx3M/eYwoy1LApaqWBc/1
 p17fF564jcP8Vx65M3OkMl/J9QuTUECIXwfcIhYwJ33X7IsOat1VPPFv2rXkvKHpLElnMDal0
 Hbk3G7HkXa/WjkYYXJBstra7X1nkLgXdaIejoBlKHqZfZvIfwK4WyI9rxcDo24ruQuy6jAYAt
 u5MIgQxwuD/8Hb5pnarfB5pZ7sYd6H6rhavzZNZZErNBnDILsGbU3xn1OE1hRaHqoxWnvMu6Z
 YP0PlHqwzyer3pQJD7riCikmnTEQqKGBHYKSR5JJA5/QEy4UT+A4DlFrmM6VjPhKbUPUSv4Kv
 mhhetzs+odrUHAOzRodGFTS67+ynxhMNIVhj2mCtFewUGtUZqzRlqTln/HeejCUjtVChsUEcP
 8ZVIpEAA9WG1ihCWhhw+CsU3vbSBPuI3VrE3cJa5Wgj0LiW6oB0WvWgMuInnGDV3XuVqjbrG6
 gjLvcONxErIzJ4zxG8UhYXnrg515C+0SolZfLS/vBv3XvFJrNkuRxPgL5TfED7ZL6F/Hasgbk
 FzJp2pqiiQhAfWNOoggJ54fkQXo+3v1bC/mtszBLS7R8edJeP82LJRcJ1cF10hi+pDxQbKusn
 nNv357661NOGU0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi Iwai,

since v5.17.0-rc3 my system (HP Elitebook 845 G7) fails to suspend to
disk and instead just hangs. Rebooting via the magic sysrq keys is
still possible though. I bisected the regression to commit
b837a9f5ab3bdfab9233c9f98a6bef717673a3e5 (ALSA: hda: realtek: Fix race
at concurrent COEF updates). Reverting that commit removes the problem.
I you need more information, I am happy to provide it.


Best regards,
Julian Wollrath

=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
