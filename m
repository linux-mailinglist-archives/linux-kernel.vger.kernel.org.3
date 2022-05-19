Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28052CC24
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiESGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiESGqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:46:54 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC337AAD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:46:50 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220519064644epoutp0159e39d705765fd5824362bb07183b54d~wbrkrVL_V0092400924epoutp01z
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:46:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220519064644epoutp0159e39d705765fd5824362bb07183b54d~wbrkrVL_V0092400924epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652942804;
        bh=/a68wlcMYyDaLAd/nI2LhXyiUaSh3jOn1FZyWEUDAg0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=j2o6NJf9S6GqmHT8nlmz+pwOLonr4pbkOd5m+id8EtxSp/KMx+R/GQ7iJneSbgcSk
         OVVcbR6fBMbGfNnrWejjKKYSARqnv0eapFZrjq+sAF8JL16e5CrI6ufb45cD87IZmB
         XY3/xsFQ9nMb2oIdEhmU4WbJqi/uiG3C0hRE+PIU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220519064639epcas2p268d3cdeed4c567fd6d11373ea04f1b21~wbrf3KnGo1287512875epcas2p2C;
        Thu, 19 May 2022 06:46:39 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L3gPR1KkSz4x9QM; Thu, 19 May
        2022 06:46:35 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.28.09764.9C7E5826; Thu, 19 May 2022 15:46:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220519064633epcas2p28c2173de91fa3c04ab0223c20bd3fd6d~wbrZrS4W51237012370epcas2p2B;
        Thu, 19 May 2022 06:46:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220519064632epsmtrp10fe81c4f406bae3f8d3d506f11d4c693~wbrZqV0Yk2588225882epsmtrp1j;
        Thu, 19 May 2022 06:46:32 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-79-6285e7c9f70d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.31.11276.8C7E5826; Thu, 19 May 2022 15:46:32 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220519064632epsmtip200b7e6dbf3c3f837498a23f955b6aef7~wbrZgIfk90800508005epsmtip2V;
        Thu, 19 May 2022 06:46:32 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     <daejun7.park@samsung.com>,
        "'ALIM AKHTAR'" <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <bvanassche@acm.org>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
Subject: RE: [PATCH] scsi: ufs: Fix referencing invalid rsp field
Date:   Thu, 19 May 2022 15:46:32 +0900
Message-ID: <000001d86b4c$2d460640$87d212c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGxVZvV+SXqOOTuFkA2CfROecP6UgKFUAa1rV/B96A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmqe7J561JBpOWyFg8mLeNzeLlz6ts
        FgcfdrJYTPvwk9li1YNwi0U3tjFZXN41h82i+/oONovlx/8xOXB6XL7i7TFh0QFGj+/rO9g8
        Pj69xeLRt2UVo8fnTXIe7Qe6mQLYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZ9zad5OpYCN/xZZX+xkbGPfxdDFycEgImEj8W2rTxcjF
        ISSwg1HiyNG9rBDOJ0aJDQcWs0M43xglfv4+ytLFyAnW0X/uFyNEYi+jxMWmfqiWF4wSp55d
        YwKpYhPQl3jZsQ0sISJwhFGi5fUhRpAEs4CDxMkHO8CKOAXsJS6+XcEMYgsLOEq8WnGIHcRm
        EVCV2PD4IRuIzStgKfFlaisLhC0ocXLmExaIOfIS29/OYYY4SUHi59NlrCC2iICVxPu5K5kg
        akQkZne2MYMcISGwg0Pi5IzfUD+4SDxe1wnVLCzx6vgWdghbSuJlfxuUXSyxdNYnJojmBkaJ
        y9t+sUEkjCVmPWtnBAUfs4CmxPpd+pCQVJY4cgvqNj6JjsN/2SHCvBIdbUIQjeoSB7ZPh7pA
        VqJ7zmfWCYxKs5B8NgvJZ7OQfDALYdcCRpZVjGKpBcW56anFRgVG8NhOzs/dxAhOtFpuOxin
        vP2gd4iRiYPxEKMEB7OSCC9jbkuSEG9KYmVValF+fFFpTmrxIUZTYFhPZJYSTc4Hpvq8knhD
        E0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1Mze7Rk71W3n3I7HnJXLjB
        m/HxgqCW7ncK3gXHMpOFMl+l/JyxrTnBbyn79wQXvoTY696CZgzTChwniZWlNj/ZWlsl4JSu
        Grp4HeP8RoWvZ/wNHTdfFF++S/JceIW3ni2XbsX6l7KXjqyfMa2DPbi6dGHvp2yNVtO11XpL
        Qg/PO+rAXv5ZOG5m8YXvZuJ/BXyO3969V9C34NMZM8aEW1USSeY2unK2l4otjZKeS+2bw/jm
        RqTQhTle+05eZf9n5BVz5eIO34bzLhc63vDk5S4U5HlnanL9eeoi/imb3m4Tm3vi9GWPxqqD
        UwtNBae+/OvCJfQof4WzEfsBGeEJK7+JabS8tjvY1OP+tU5z7RslluKMREMt5qLiRACtdCZ2
        PQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvO6J561JBsdPW1g8mLeNzeLlz6ts
        FgcfdrJYTPvwk9li1YNwi0U3tjFZXN41h82i+/oONovlx/8xOXB6XL7i7TFh0QFGj+/rO9g8
        Pj69xeLRt2UVo8fnTXIe7Qe6mQLYo7hsUlJzMstSi/TtErgybu27yVSwkb9iy6v9jA2M+3i6
        GDk5JARMJPrP/WLsYuTiEBLYzSjx8cBhJoiErMSzdzvYIWxhifstR1hBbCGBZ4wS7//qg9hs
        AvoSLzu2sYI0iwicYZT48GArkMPBwSzgJLHnZhLE0BZGiQMLvrOBNHAK2EtcfLuCGcQWFnCU
        eLXiENgCFgFViQ2PH4LV8ApYSnyZ2soCYQtKnJz5BMxmFtCWeHrzKZQtL7H97RxmiOMUJH4+
        XQZ2nIiAlcT7uSuZIGpEJGZ3tjFPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBYZ5
        qeV6xYm5xaV56XrJ+bmbGMExp6W5g3H7qg96hxiZOBgPMUpwMCuJ8DLmtiQJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwKRf3CdqdMcrbrXMkQefj5Rd
        lpnnfvRfr77ngZa1Sw5nn4ntXPLc9NXGtaeL7l3YUrN5zVWRdUWci57uvGDhZlDJNSnqf4eq
        2Lzf+o1X0m6wBkS8XJyTq53/feaWoj3uxzbk7PFYasJQcu3Pq23B2p/CVx+PLxQWq1/Iy7Pe
        6JJsw9fmI5M2Oy7tcLjIdWNKeu8bpg9q9ZanLmXwHWW33JM0oUXusfmqJUs7lvCbTWNt/mNe
        NbPQ7MkxS1VXvX/CDGKbGu4lPBE5p8Pb4hbhr3P5uLiSWvEdoUkXg15/FpjTcbtgzlGnmVuO
        NV1iKOdLZe0RcUzd0jXtt3GWzATJiZNCSyUVyl4c/taxQJ4ztEiJpTgj0VCLuag4EQDawYAK
        KAMAAA==
X-CMS-MailID: 20220519064633epcas2p28c2173de91fa3c04ab0223c20bd3fd6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612
References: <CGME20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612@epcms2p8>
        <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a patch for fixing referencing sense data when it is invalid.
> When the length of the data segment is 0, there is no valid information in
> the rsp field, so ufshpb_rsp_upiu() is returned without additional
> operation.
> 

You should put a proper fix tag to be applied the corresponding stable tree.
See https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Fixes: 4b5f49079c52 ("scsi: ufs: ufshpb: L2P map management for HPB read")

Best Regards,
Chanho Park

> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  drivers/scsi/ufs/ufshpb.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c index
> f1f65383e97d..8882b47f76d3 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -1304,6 +1304,13 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct
> ufshcd_lrb *lrbp)
>  	struct utp_hpb_rsp *rsp_field = &lrbp->ucd_rsp_ptr->hr;
>  	int data_seg_len;
> 
> +	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
> +		& MASK_RSP_UPIU_DATA_SEG_LEN;
> +
> +	/* If data segment length is zero, rsp_field is not valid */
> +	if (!data_seg_len)
> +		return;
> +
>  	if (unlikely(lrbp->lun != rsp_field->lun)) {
>  		struct scsi_device *sdev;
>  		bool found = false;
> @@ -1338,18 +1345,6 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct
> ufshcd_lrb *lrbp)
>  		return;
>  	}
> 
> -	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
> -		& MASK_RSP_UPIU_DATA_SEG_LEN;
> -
> -	/* To flush remained rsp_list, we queue the map_work task */
> -	if (!data_seg_len) {
> -		if (!ufshpb_is_general_lun(hpb->lun))
> -			return;
> -
> -		ufshpb_kick_map_work(hpb);
> -		return;
> -	}
> -
>  	BUILD_BUG_ON(sizeof(struct utp_hpb_rsp) != UTP_HPB_RSP_SIZE);
> 
>  	if (!ufshpb_is_hpb_rsp_valid(hba, lrbp, rsp_field))
> --
> 2.25.1
> 


