Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617D34B7644
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbiBOUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:47:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiBOUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:47:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6FD93;
        Tue, 15 Feb 2022 12:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644957995;
        bh=0OSbOP7dVuxah5dzxOSWPDpWQt+waq4IO/yrm245na0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RM8lbqfXj4CquNffPjLDAk/zqsA2R7oPEntJIfErC/JFzifQUKiCCwI3sQ/AwS3UH
         u+PDvEN61F59Ofw1QXdQ7s99jAvoAWJRtsvl3CYAHnhMh1rMymay5Nv8yKR1A9xG1K
         XK+pIDDlkBrtJwgBGiQ/YPmKR4xRWeE8wNcYaJAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.185.100]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1naNTk1Cfr-00KivD; Tue, 15
 Feb 2022 21:46:35 +0100
Message-ID: <7e60cd01-8afc-ddb5-a1bb-6e9f53ccfba5@gmx.de>
Date:   Tue, 15 Feb 2022 21:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 22/23] video: omapfb: dss: Make use of the helper
 component_compare_dev
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>, srv_heupstream@mediatek.com,
        Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-23-yong.wu@mediatek.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220214060819.7334-23-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MjTT6/0mKscyzurmEJq+TRDLFWm722/o5oh1VceIWTDo9Su6z33
 Uqcw4r79WPXMZ1MHVQ5YZwMpT3/LUtQYuMEKT1s4Qsw268nztXs8M1PHTdwFSaaX3fRCVHa
 I5hj8j+9RzGYlu8e8qiZ43jIdVRKdmD+CGxvzWPF1Cw57f4/4D8ejp1FysOEiqU6iTGSqwc
 ErfKQfh2UKAhLIHNSceWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EO1+Ylb+ev0=:HpXUahwDBxS2Q6GJ/UdQMa
 n+62M3husXUXoHxxs8AxzjuuYDkqIBegYnyeAV7YgP0Mle0rT21+2LEV21Cm/oK+NdFah8S9W
 CpzPyAZIRuU01jq211YudtbXnvFOMgwbjvey4rIl2NTTJUDs+3nbJ6EgXSJwHO77nbgaCNttA
 G+VtN7qVCXCtu780Msj9tZjo7C1oDNvtl1Z0DVM0OdyjyuO5D93T57PbebQJO+46L8tQ0bfg4
 PClJhDBMO98xxmJRVp6iBSjNS7q7geteQaZ0ZJQVZhNyuKpKUNS7ESMvNsPEhSTzcXNJDdgSx
 Vq9g3AnCPk01P40v1QI4BqRKbdc93kQn/QMzvwnd6VKhhT5hOO0TqppV8u07Mwhznrax7VcRW
 +v1Ixw3WjKmrwEdG4wxBOsqT1dFC/6QoqorX3z1sqp7Ag6Ncwj2vZEjoNZ1YUThIr4BpD/vWq
 hjpVXVTw/vir74eHyvdnz2eZXfQD7YPWYiK3z1oTwSGkoUciP9hPqvp4WS1qWPD3Wx4UiMz4y
 2dpK2641P1xHzfATt1y9hhMgc6vt9XFxpm9Ycl0uN+Nf/W9WIYa2fD+vPujh/CyO3jLklKrNP
 rhbT5NjDJGfC/AFaC2iH75aCY+P5r1pQZOBnvTunjmLUTuER4bhCqMQqM9G+WAIVA1mScRE7x
 z5RtmJWkKSwplc9SI/e09hsIAALu0cz7R3+T3vF1BUPB0RwiiTFPg2EbSOsu0l9GrJ8CkvoHP
 6ajgPfPMXcn62tOWZWD9MMtunWjyjGeCeU0sZsO37FBgxO6O75XX5KNPo3ZtVKQ/rb45z2Rj6
 BmFoOKHsV5p6ypFwr9d2I3zNEcl0DYDNBnMwKA/3QTkYeOJgYkBDK8DU7dxFOUM6q9OWcMRcY
 NoMQI8g/0H0GxrMHZA3BmETGV399e4Ve0zB9yhBv/cd9YdH0LKj0wm2/KEIbC/oPNQrOB040l
 zX8J1rybbjKBBzimlhU2e1yTmGHdV4geJl204qxFdDOHSN0uiAnzvI89ljAQcys4MdV9EpQSa
 NnChsjeiQrZB5ZntJzdsbaO7RJJahTHLc0+epBUeuUd6C0orPGZgiQsH8Kwcy4p8Uu6vZoYIV
 JC4pPsVjDwiUHc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 07:08, Yong Wu wrote:
> Use the common compare helper from component.
>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Applied to the fbdev for-next branch.

Thanks!
Helge

>  drivers/video/fbdev/omap2/omapfb/dss/dss.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/=
fbdev/omap2/omapfb/dss/dss.c
> index a6b1c1598040..45b9d3cf3860 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -1193,12 +1193,6 @@ static const struct component_master_ops dss_comp=
onent_ops =3D {
>  	.unbind =3D dss_unbind,
>  };
>
> -static int dss_component_compare(struct device *dev, void *data)
> -{
> -	struct device *child =3D data;
> -	return dev =3D=3D child;
> -}
> -
>  static int dss_add_child_component(struct device *dev, void *data)
>  {
>  	struct component_match **match =3D data;
> @@ -1212,7 +1206,7 @@ static int dss_add_child_component(struct device *=
dev, void *data)
>  	if (strstr(dev_name(dev), "rfbi"))
>  		return 0;
>
> -	component_match_add(dev->parent, match, dss_component_compare, dev);
> +	component_match_add(dev->parent, match, component_compare_dev, dev);
>
>  	return 0;
>  }
>

