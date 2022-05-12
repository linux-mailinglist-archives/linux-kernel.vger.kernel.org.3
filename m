Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8332E524983
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiELJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348542AbiELJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A25042EC4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652349276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fi0YhV364tas2tIudHmBj0yV1vo+oCMyyhwL6b5uu0w=;
        b=KcAQv4LAi5JdAPCL2zTMUBG1Pn5RHTWgm0UTfUy3NUjDexYl5nG/fI+8yzBMi4STpceLPB
        FtQ8GD/SFAFCbRyjDg8e7/eRV4Gzve4ya3qXLgKzZtHpxs7D9ENphjOJLZ5qvKuLQLt9mm
        BDIArGtVeThcX2qLVW0rS4hug1sqV3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-SpLk0flOPxeDfrd9Z0No2g-1; Thu, 12 May 2022 05:54:35 -0400
X-MC-Unique: SpLk0flOPxeDfrd9Z0No2g-1
Received: by mail-wm1-f71.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so1462088wmi.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fi0YhV364tas2tIudHmBj0yV1vo+oCMyyhwL6b5uu0w=;
        b=Fk9VsbxoRzApZZuhlCVnoe6EdbcXeKi/ZaZWqjU7X4s+vZS5vZAnSNrQHtUtBH95Sc
         9sc0uKYLL+bSWYjKtrT+lNOP7Rn+wm7TtgoudMdenj3Lc5yeiTW8C4sTOurqoA+KoJyH
         D1xnWWpsndDEF3eH5Sz0HTq/0ke/blsMHN0BlGnPC6fR4Y3bD6xxDb+f5SspRvDAi9cV
         9O7DjiBWtUPmzfV4seN80d4sxXLTf6VE2n1l9Ylu1rGDW8WBgMJYy6lNuMwt/JjEDwhm
         0nA0fGV/9RnhI+tG00DDnIc6Z4TNv0Bl4CnSNFlyWJla3cJM/u8tAEwnFS9YVuvaLCEq
         bNNA==
X-Gm-Message-State: AOAM532EnCkcSeevNmZamgYTra0KGSmDIjHDAhakEcB492HvycRLiehX
        yxB97VRatWfV4KnaotYmnTUIkeoYxcrGM9aGyjDBi6yKgHPNsG7h9uDkhJ2yMwreyVqHhaAgyl0
        Gb7o8dJ5WZSQm+e9Y05mOy2Wk
X-Received: by 2002:a05:6000:1283:b0:20a:e149:a9ab with SMTP id f3-20020a056000128300b0020ae149a9abmr25892802wrx.330.1652349274159;
        Thu, 12 May 2022 02:54:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN0msJfeisZ8RL0PLfCeAg9VdgRAnmPHNuzy1XxhUiOqdAF99zc+iQzQhd6iiK1NMw8ABnsw==
X-Received: by 2002:a05:6000:1283:b0:20a:e149:a9ab with SMTP id f3-20020a056000128300b0020ae149a9abmr25892789wrx.330.1652349273959;
        Thu, 12 May 2022 02:54:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d460e000000b0020c5253d8f3sm4545885wrq.63.2022.05.12.02.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:54:33 -0700 (PDT)
Message-ID: <165b01be-71c9-7737-3a78-124220ce59d0@redhat.com>
Date:   Thu, 12 May 2022 11:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/1] mips: rename mt_init to mips_mt_init
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504002554.654642-2-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220504002554.654642-2-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.22 02:26, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Move mt_init out of the way for the maple tree.  Use mips_mt prefix to
> match the rest of the functions in the file.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

