Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE26C4F897F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiDGUjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiDGUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:38:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E5345D62;
        Thu,  7 Apr 2022 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649363116;
        bh=DlbOpXdlheJlXvoOey1WuM162xwLkn8EcO/3A3LfIes=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ISVjbvZ4W/FVDTaW8PzYEnrlar8SoPAFSzU6vkATj8nnOBo243llbtTDlWtea8NF6
         KivKy/3R22fq8DH5pQFimKbuTW4DIS3U3Wyo83UPbPk8ryUCAQuOiqmlXur0wEa/LL
         GWDLf4a9mQDSABFUS2zmbTcGy9S9E8XXBTYogVTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.122]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1nKkAE36sj-00Hzfk; Thu, 07
 Apr 2022 21:42:59 +0200
Message-ID: <67698385-b2fe-2de9-9775-9f6320a0e9e3@gmx.de>
Date:   Thu, 7 Apr 2022 21:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] video: fbdev: Fix missing of_node_put in imxfb_probe
Content-Language: en-US
To:     cgel.zte@gmail.com, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220407090122.2491922-1-lv.ruyi@zte.com.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220407090122.2491922-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p8vzFrrvIKVFtaDT5l91hwUiLPe13/ZAgxzuyd2hmZIvj7Byh+E
 bTNrO2hlWJyT3u/MXuenFvALE+UwOdfIacAKaHtRH/4at5tF8O2x33miZCZSrd5HVyRuVSl
 uKygwSj3diqZz43fAJYPAVr/6FSb/UZxRBISPq2bS1hQj8AuZMdCTjutD0IhOWzFdU2+i53
 B4UU9mCfo86WAK2ZpyZpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MT51GlYzjyc=:ek4qURxclpD/olO6J+acDd
 wQTkL9Zpo5+pfflMX+aQKvkNLtI1eKVO5kLJy1fDF3s9KqTrfKwcL/WymWo7tIEfsv4K9R6rC
 xYJ1Rpq2JPu6Kt6H+qRp54y3q0hSOWTUGKUzKuRvH4nRgcAIMtICylmx51DeoBVA59vrDUTsL
 ujsdtDiyjgoOvYueDoleErWOmzKF7B+eGqc9GRqiz0F2ekD5LSRYU1ePMPTDPwv/JkPis73/6
 tX0Ni1NnACcPNWcAVUJZZ5qCwrwlFYNkWfmjPNANuHtbKoNR+KYvo72IhKaPSJSmpP0oDTBLL
 M06usSYH5ka/o0hqSn1lO8o35dyLFXd7fh8RfhLKZBIi43kgwuRMhYd/+WBYvUN0OJOOLgcYy
 roUeakhuvhKOPAqm3AtT+QS3SHn0KZ8rdiMOr8pIICmGn4At9s7TA4HJjFzv+HdQ3MSf0KvtQ
 4NlkYYDsEhhoQJxLd95ACeEoAI72Jtol6jJpgw+H77WFDTvhHYTR9IC0ga7dsufi2faX9u8kZ
 FAZ5QZum0gt1lq46JDWE9QZ/+yNZnh4yE+bKSBHgvJbXxOE005pQdpXQJ9w6yoCsBQcoqDxer
 HBaL74XqQ7nZ+gDWtO04t8Fz/4SxZ2mIHioQF6i7QHUdOA8kLqLMiCH7xNj5FHwbO4tm40hUf
 3eFb6jJSsDK99cmuIbEKnV34VkYCkurdAobiRfNwxDDvIvC3uMhb9mmY7bM8NDaSuvfglEMrV
 qszoaF31iVjVkvYmPZrsV+JAwoNICgYzwbmSpLrlt0X/bQxqJLm1DSYHS0RfFk9vba2hOCFMz
 6Jza3Pxq17/j6x9v4ATEVRzGkkTsNeVkV7NKXQtqZgePf0AlQLu1Xj79uuwxK3Q1o/qarPSKL
 f0jSYV15DBkBOmmREXJcoUH+MgqR2sYiyK1TB0fWH7rZZrLTH3Hoaez3Bv9Sj4NspjnRKnezC
 rq1zk1JxV5AQ++gCQvQ+iZ3ULLzrmw/Y0uYcxfe6NuVkTdQBFC8iaRNUwqT/LwVewd1HS82U7
 8ekTcfZothpqJeUEhX2FOcuiWFEJKZ8gMKF6P5nNgQLmFqX0nrQwNsPc+p9uShouTcd9MlRhI
 JBlDpmHqXsjkRw=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 11:01, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> of_parse_phandle returns node pointer with refcount incremented,
> use of_node_put() on it when done.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/imxfb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 68288756ffff..a2f644c97f28 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -925,10 +925,12 @@ static int imxfb_probe(struct platform_device *pde=
v)
>  				sizeof(struct imx_fb_videomode), GFP_KERNEL);
>  		if (!fbi->mode) {
>  			ret =3D -ENOMEM;
> +			of_node_put(display_np);
>  			goto failed_of_parse;
>  		}
>
>  		ret =3D imxfb_of_read_mode(&pdev->dev, display_np, fbi->mode);
> +		of_node_put(display_np);
>  		if (ret)
>  			goto failed_of_parse;
>  	}

