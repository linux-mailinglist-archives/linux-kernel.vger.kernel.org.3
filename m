Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6359C3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiHVQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:20:09 -0400
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A463F1E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:20:05 -0700 (PDT)
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MGJXLW013205
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pps01; bh=lL+jIgSBvIyxjoVVxdSt+mBrExHYO8gEXwp3Ap6tqQo=;
 b=UqBpfOENWlJJ0MexN1mHDsEnXyGak24lZVN6ZwkcAJbbObwDSklL8O7xsxeaMCkejEjn
 NxRrBzB+Ck9YOmH0dwXk1eevCO5Y8Q7zTe8qHFzA3Ab04IWpq1k/RlKvPpEhcrlFZOSB
 rKiYMVODiJ0HmN3thjL+QDRsjwViB2FSNN34LClpkJRE2ml8qfX6cqH3iyypRUWvC8p2
 WmBaOU0GiwDr81py9Kzph+Xi3UOoU0HlrXoaTZ+S2Kpqcp4J1lAMuoL0sivm3OhY/SUP
 46lmEF5Z4SZYlw0sXej0CMlKzRTFXBlv93BVhR2sS8pmHM96pVh9tsvbb0ofB8jSrXqO bw== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3j2wj6bm5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:20:04 -0400
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 27MGK2nd026682
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:20:02 -0400
Received: by mail-vk1-f199.google.com with SMTP id b19-20020a1fb213000000b0037d0dfd4db1so1811354vkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lL+jIgSBvIyxjoVVxdSt+mBrExHYO8gEXwp3Ap6tqQo=;
        b=wdFyvcMRrc4SctGn1DhOZKh705IqvwqLkOT50PJUcJj3HokAtoIPdeS1IXTfMgHWYE
         1Jpjby5fZlWqftpWhOT7x68wVQldFGGgD/kHqGWDm2lvwqlFv0JViJowpyCpXrZuk5HN
         C15mxiTdaf0oNX/7xoo7QzNKhdhzraTaKmT3/UOi947KwKvPmI1jqxjVrJ0SGw6z/R9E
         KdBOPaKulUteAme6mSM+1leEzvTwOBi8BTOgWoB0Gy5HcIsnekO5PjJPXqeJpPbCi5ol
         HCXF6INeFtQo726d0rnHcbQuly2ZVBKN8ObpRrHNV+X9EkEXdrUqGJMOdClFFicPuoqY
         qMwg==
X-Gm-Message-State: ACgBeo1Du7wcIL7p+2TRa8oMjCm+dd+b+oCahMTizJMN3hmcmvj4NG0Z
        RnpXpXbn+I/iJfM21xskUjJz4KMtm13vxAHvyRLfJrTbVSOzVuzFPzsaRr+tvf3BXxH4yn4y10W
        LR+8C2E+xn6qIKVxjsjAWAabk8zwSSBGKm6niA2KeCexD0QKT
X-Received: by 2002:a05:6130:64c:b0:390:f639:5ac4 with SMTP id bh12-20020a056130064c00b00390f6395ac4mr7692150uab.98.1661185201989;
        Mon, 22 Aug 2022 09:20:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4aDBstx+gZ0tfQtYI/tazQw44//p/soUNDTq7MSnhgREgUkhWqjWhJO8bkdWbFSdUzkD9ocmCnPa8xyVA9HvA=
X-Received: by 2002:a05:6130:64c:b0:390:f639:5ac4 with SMTP id
 bh12-20020a056130064c00b00390f6395ac4mr7692137uab.98.1661185201773; Mon, 22
 Aug 2022 09:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB24-9hXY+TgQKxJB4bE9a9dFD9C+Lan+ShBwpvwaHVAGMFg@mail.gmail.com>
 <YtoWqEkKzvimzWS5@gondor.apana.org.au> <CAEHB249ygptvp9wpynMF7zZ2Kcet0+bwLVuVg5UReZHOU1+8HA@mail.gmail.com>
 <YuNGR/5U5pSo6YM3@gondor.apana.org.au> <YuuZgsdmJK8roKLD@gondor.apana.org.au>
In-Reply-To: <YuuZgsdmJK8roKLD@gondor.apana.org.au>
From:   Gabriel Ryan <gabe@cs.columbia.edu>
Date:   Mon, 22 Aug 2022 12:19:54 -0400
Message-ID: <CALbthtcfPn5qc0HecmK9iN-o+ZWDVid4bwzZJmO2sthw3fKFBQ@mail.gmail.com>
Subject: Re: [PATCH] af_key: Do not call xfrm_probe_algs in parallel
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Abhishek Shah <abhishek.shah@columbia.edu>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, Fan Du <fan.du@windriver.com>,
        Steffen Klassert <klassert@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: kVkg5wvMRzMcSeBmF6pNyka3-AoshHSU
X-Proofpoint-ORIG-GUID: kVkg5wvMRzMcSeBmF6pNyka3-AoshHSU
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=10 mlxscore=0 clxscore=1015 impostorscore=10 bulkscore=10
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220070
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can confirm we tested this patch and it prevents the race we
detected in xfrm_ealg_get_byname / xfrm_probe_algs.

Best,

Gabe


On Thu, Aug 4, 2022 at 6:03 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> When namespace support was added to xfrm/afkey, it caused the
> previously single-threaded call to xfrm_probe_algs to become
> multi-threaded.  This is buggy and needs to be fixed with a mutex.
>
> Reported-by: Abhishek Shah <abhishek.shah@columbia.edu>
> Fixes: 283bc9f35bbb ("xfrm: Namespacify xfrm state/policy locks")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index fb16d7c4e1b8..20e73643b9c8 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -1697,9 +1697,12 @@ static int pfkey_register(struct sock *sk, struct sk_buff *skb, const struct sad
>                 pfk->registered |= (1<<hdr->sadb_msg_satype);
>         }
>
> +       mutex_lock(&pfkey_mutex);
>         xfrm_probe_algs();
>
>         supp_skb = compose_sadb_supported(hdr, GFP_KERNEL | __GFP_ZERO);
> +       mutex_unlock(&pfkey_mutex);
> +
>         if (!supp_skb) {
>                 if (hdr->sadb_msg_satype != SADB_SATYPE_UNSPEC)
>                         pfk->registered &= ~(1<<hdr->sadb_msg_satype);
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Gabriel Ryan
PhD Candidate at Columbia University
cs.columbia.edu/~gabe
