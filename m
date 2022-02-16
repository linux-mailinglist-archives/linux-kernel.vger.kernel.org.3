Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413A34B7C51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiBPBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:02:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245235AbiBPBC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:02:29 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1748879F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:02:17 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220216010215epoutp044337a28cb135aa681bc0844dca9cc084~UHohwmpF41566215662epoutp04C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220216010215epoutp044337a28cb135aa681bc0844dca9cc084~UHohwmpF41566215662epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644973335;
        bh=W76p5lzZuTrN/LwNZhMY5heYVmdXwnLF1jR2bQKZcjo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FXAIq+y8cRIA6LpnoiMatK9GdAARFEDOdeoNWfKvMf2a7vEge3vaFskuwbXZA4D5b
         lwubJybHcTpg9emuqhAYgaWQimXVaPUl+S32y+epmLjjDGDwFJS6+KkZjpZ0SC0fyB
         BbbOpbyd/ARsplgLodSfXN6I4QfzyAXA8sNKdZpA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220216010214epcas1p2f4e8fe0a9815a2e4f2667ef9daec3820~UHohgW00X0154301543epcas1p2g;
        Wed, 16 Feb 2022 01:02:14 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.136]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jz06V1DySz4x9QQ; Wed, 16 Feb
        2022 01:02:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.B1.28648.E0D4C026; Wed, 16 Feb 2022 10:02:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220216010206epcas1p3532638080c2ec47aec8add2f126128f8~UHoZvVtk91822018220epcas1p3O;
        Wed, 16 Feb 2022 01:02:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220216010206epsmtrp20792e037782f16ef98bb9cd82ee04ef9~UHoZudLhE1789517895epsmtrp2u;
        Wed, 16 Feb 2022 01:02:06 +0000 (GMT)
X-AuditID: b6c32a39-003ff70000006fe8-1d-620c4d0eb184
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.C3.08738.E0D4C026; Wed, 16 Feb 2022 10:02:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220216010206epsmtip18ff9dd2f9c213256a4ea2d57c17fa31f~UHoZiM0P03127131271epsmtip1L;
        Wed, 16 Feb 2022 01:02:06 +0000 (GMT)
Subject: Re: [PATCH][next] extcon: usbc-cros-ec: Use struct_size() helper in
 kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3136d3aa-4c01-33be-86de-1a2b3b6b6733@samsung.com>
Date:   Wed, 16 Feb 2022 10:26:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220125192634.GA70834@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmvi6fL0+SwY8PlhbTn1xmsTj1ahmz
        xa+L01gt5q3/yWhxedccNovbjSvYHNg8ZjdcZPHYtKqTzaNvyypGj8+b5AJYorJtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM870bGUt6OCu
        +L7xEVMD4ybOLkZODgkBE4k/TZOYuhi5OIQEdjBKXDz7mxHC+cQo0d2ynh3C+cwo8X0/SAai
        5fubGcwQiV2MEt/+P2eFcN4zSpybdY8FpEpYIELi/+KHYAkRgeWMElOf32MDSTALOEq0vt4M
        ZrMJaEnsf3EDzOYXUJS4+uMx2ApeATuJ20dusYLYLAKqEgdnnWUHsUUFwiRObmuBqhGUODnz
        CdgyTgEDiZsTzrJAzBeXuPVkPhOELS+x/e0csFMlBHo5JN5/vQr1g4tE579DULawxKvjW9gh
        bCmJz+/2skE0NDNKNLy4zQjh9DBKHH3WxwJRZSyxf+lkoBUcQCs0Jdbv0ocIK0rs/D2XEWIz
        n8S7rz2sICUSArwSHW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF5J9ZSH6YheSHWQjLFjCyrGIU
        Sy0ozk1PLTYsMIVHeHJ+7iZGcNrUstzBOP3tB71DjEwcjIcYJTiYlUR4485yJgnxpiRWVqUW
        5ccXleakFh9iNAWG8ERmKdHkfGDiziuJNzSxNDAxMzI2sTA0M1QS51017XSikEB6Yklqdmpq
        QWoRTB8TB6dUA9OG3YJ9EdeOJ/7XZQrPl/6ysenr6w0Hw9LKwsVOrJ3xyyplx+ca8apZloVn
        v1bFVW80+BW+3nmz1qbI1Nlpxqrzppa9LvxWFuB57nHC22nCzG0bftoHP3nvJPTLxl/F2PzC
        w4bg9Z13D+sr74mw1WFfcbk6I4A3wM+efYY9/yzb77UcG/8H5xf+15nrWx5r8OL2jxzJ8Nlt
        0obHGcNXXPw18/2iCodLDqL2N3emSf59/+Gn6vXrmwo1U40UiqtX+Bg09B6an9toaLDjfpn9
        p82Pn6e5st48kH6vk0ExnTHbPo/lpt40lY60ZunwZVFnOP+9sVvdfWPCT+ndaW7vZs7942oS
        G5PGZLeJ92bgYiWW4oxEQy3mouJEAK7fnyQkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnC6fL0+SwazP8hbTn1xmsTj1ahmz
        xa+L01gt5q3/yWhxedccNovbjSvYHNg8ZjdcZPHYtKqTzaNvyypGj8+b5AJYorhsUlJzMstS
        i/TtErgyzvRsZS3o4K74vvERUwPjJs4uRk4OCQETie9vZjB3MXJxCAnsYJTY2jSRBSIhKTHt
        4lGgBAeQLSxx+HAxRM1bRom9P5awgtQIC0RI/F/8kBUkISKwnFHi9YGZYAlmAUeJ1teb2SA6
        mhklJnffA0uwCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCdx+8gtsBoWAVWJg7POsoPYogJhEjuX
        PGaCqBGUODnzCdh1nAIGEjcnnGWBWKYu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJ
        yywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcPVpaOxj3rPqgd4iR
        iYPxEKMEB7OSCG/cWc4kId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpiixc4XzDZd9On0rv13nOu9ItSPm/5d8zoqZA73mz08hZprv8Syq96fufBdfFgI
        w9wJ3seufhHJYLb/9e1rs/iFW00Sp7Vm52bfYGWqP8kyYe3Mrj28XTemLRHxMHZbsMWrxVH4
        xz6Hj2KmohJac4rOpt+0Dby4iOVbYYChXcjnrZPE+Teeyp4j/uTHhlzN6w86uaev6eTKDfa4
        eJt1+12mkJKVbsJMcf0zMz+FNZ0TuZl6Zs3GtFc1ne8Vpb7P537pezA/cc+fFcnLUs/P1ZO4
        2a++IWtr+vPIHg9lQfcGzQDRX8anliVvWZDZuJHN7sn2H2dk0mXCLTaZrZ2qondhn872hUfu
        7H8taGjAYaCjxFKckWioxVxUnAgAcHk94Q0DAAA=
X-CMS-MailID: 20220216010206epcas1p3532638080c2ec47aec8add2f126128f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125192140epcas1p27d09a1d2ceaed49dd7c410c0223c51d7
References: <CGME20220125192140epcas1p27d09a1d2ceaed49dd7c410c0223c51d7@epcas1p2.samsung.com>
        <20220125192634.GA70834@embeddedor>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 4:26 AM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/extcon/extcon-usbc-cros-ec.c:71:23: warning: using sizeof on a flexible structure
> 
> Link: https://protect2.fireeye.com/v1/url?k=2dc5c327-725efa52-2dc44868-0cc47a31ce4e-cb277ab0badba227&q=1&e=e53efbe1-ab25-4a39-a8b1-9e099fcccde3&u=https%3A%2F%2Fgithub.com%2FKSPP%2Flinux%2Fissues%2F174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/extcon/extcon-usbc-cros-ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
> index 5290cc2d19d9..fde1db62be0d 100644
> --- a/drivers/extcon/extcon-usbc-cros-ec.c
> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
> @@ -68,7 +68,7 @@ static int cros_ec_pd_command(struct cros_ec_extcon_info *info,
>  	struct cros_ec_command *msg;
>  	int ret;
>  
> -	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	msg = kzalloc(struct_size(msg, data, max(outsize, insize)), GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
