Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076334EFBDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352565AbiDAUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiDAUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:55:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15221C34B2;
        Fri,  1 Apr 2022 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648846385;
        bh=XBQN4Y8cY6863locdXVbzi2Vq6V+H1v2SxPMFzNkCPo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OYTqi2prkndGI/ORGpjS+vnKtXl+OmGYiTqwelq0yTAS7/Jjgk+SIjpx0vY3eX+9Y
         Cpen5R+JveUaI3t44wRlqs9rF/FH7IYYmVz6t8wgx6jcmUYu6Szv5crjYh3cWyJ0hM
         M6arbyu7Bz3DghRqe/joNvt2qfAYXTtuqBFjO6yo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1nsbwV1DuI-00uupR; Fri, 01
 Apr 2022 22:53:05 +0200
Message-ID: <f6802e83-0fc6-ffe6-cea1-d2a39d768514@gmx.de>
Date:   Fri, 1 Apr 2022 22:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] video: fbdev: sis: fix potential NULL dereference in
 sisfb_post_sis300()
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1648784476-20803-1-git-send-email-baihaowen@meizu.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <1648784476-20803-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jqSUrZEkWBRjiAbZGSBMpExq4v+hgcH4biJGJErpd8gmlIXCNtj
 HSBeMgO224TpGgAVQdXvF2pmAs9LVA+J89TQNBpsezoHFqUgLMPEPevYjjkn8JlDQbPZ36b
 lQ8n0RY3EDclGiYEIetK31BqjjXu6e82as1P3vma4VwQb8B3MAsqxOWmPaC47ilbSCyrwYL
 RGFONn2o0MSQv+kZTN1Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8KFcAgyHg6o=:11aIfxQ0Zlsyeanjppqz0z
 OLNfjn00nnTIgmKHvnUhJ8klyMyGa7czYWsXDdBhiUv2dMESFbBa+ll/lAv4kMnfaXxLzoDxP
 DSaMrtArtBVxzE9vFHMzopDwDrYxEiqXkGU4me+SEnCmI//LZKBeRoBSTnW3rlj4vyK5d06P6
 EVyvtQcRuQEGRR2erhzUoGzg02RHdBz34oMC3zHJ0Nvod/3iL3t6pztdgM4zg+02TQv7K6tKt
 LXXmVS+0RYDMWo0/fx54WcxjboICJCT4al+Rh13ieDpmC5SVSbYo9t3B+kFg2e1ZSbc08mEWK
 isJ9ZoArTrwabqfz8zjazBwtECiHkwb1VW9eUm+AQCbQYOAIlDcAcrtyvzNvVUiMUQRX3vLIs
 0gIdEcX3IXY4S1HPo0Gp94qhq0Z5XTsHK3yncfLIP4j2N3j/yu7S2ZbtCXS7xMvgRlZdmGCxK
 0Vpwf4coxclXBqM7O1tRdPFwBc7ucZH1RHymZO0aP7vRnv53IqO5tlRIPMO5C5jmpcWvWejzr
 TwWFZNKsp+jq6yNkPxMK2q4DB0I7IEFcDl4N6/AyDV8zPF3Krjob+6pXtUUIOEKrc09BNx+kY
 feTd7dZMlO9VWDNw9lk01o69ss0PxuDK4X5CztukKXpsaJ33XPD1xdpt8MdeJNnJmtGbsNVGs
 DAiIfGDxB+LzLkCue+oids+pGAKEA5CoMkzHbReqGd8PZLLrl+NZzVdJOQrIQ2tDjIFkMiwPM
 CyvmIPQBZyFvvRckE0qGS1ELL0jzhIcohc/h6PJjCKVNsCCdJWZoQltfy/9gyZKKIeQwwdT2W
 /PydMo6n/qsr/crSmzyRdMAymNOt6qV6G1RSF5eNq2zThoKuGWP78FPNZRZh3OhJHmIT6YGvA
 BT6zcofyzQyisXI3VR1Znh2OposN+zUqRVYwzBytr6rY6y3dbURQ/jB4n1q7819ii8+O1DG+m
 22QgFmNy5/gpqCo1B38asxfFlBLd5eTg1J/UtuIUFMPEBRCdkBcmzGdbt2WcYynIiFGu6VD5s
 ablP2n2qanFtPOKQpleUWMT6CDFeB4i0H96Q6D9qozBQ4eewJOFr57PC/V2A9OiOq8QIY9BAh
 i3RPaaAulys7Rw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 05:41, Haowen Bai wrote:
> bios could be null without checking null and return in this function,
> but still dereference bios[0xf5].
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/sis/sis_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/si=
s/sis_main.c
> index 742f629..24a0299 100644
> --- a/drivers/video/fbdev/sis/sis_main.c
> +++ b/drivers/video/fbdev/sis/sis_main.c
> @@ -4463,7 +4463,7 @@ static void sisfb_post_sis300(struct pci_dev *pdev=
)
>  		SiS_SetReg(SISCR, 0x37, 0x02);
>  		SiS_SetReg(SISPART2, 0x00, 0x1c);
>  		v4 =3D 0x00; v5 =3D 0x00; v6 =3D 0x10;
> -		if(ivideo->SiS_Pr.UseROM) {
> +		if (ivideo->SiS_Pr.UseROM && bios) {
>  			v4 =3D bios[0xf5];
>  			v5 =3D bios[0xf6];
>  			v6 =3D bios[0xf7];

