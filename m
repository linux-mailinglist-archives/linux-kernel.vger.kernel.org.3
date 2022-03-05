Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303F4CE28E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiCEEDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 23:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCEEC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 23:02:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9326E2BA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:02:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so9498743pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 20:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvFLMgmumatclzo/ltvLrzoEdwRQhUedRHT1/FOazgw=;
        b=eBHK1NaW/TxpWQYXBiAJLfHOEVg3n8W8qiT/MZAkO4etYW24aEgyHPNGEQUX2dMKXX
         0GvIpK5GbTAhqCN8ISVozLHBMi4eCCII54/giOMnSo64dgSmTZymcp3rE3rMfyKYRbPL
         ldzWV7VPpDbQZcvY/mFIUNy93ui9g7kHyXIcRKFnci64m060TK+AVPKH+ZCYIj/2/YoD
         WKO7AIKGPbBCzLLWx/QIeQDiL9J7/0kwZK9MpwRFUvSU+6QK+QjlW4NGC4Oe+TZBHBzE
         rCvyBLcc+l6mR+PSyqkDffkwoImb5eNo5nRLpJL+ddOtZoo9k7B+DpjGeKp9HHSddPmy
         yarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvFLMgmumatclzo/ltvLrzoEdwRQhUedRHT1/FOazgw=;
        b=eWOHAVXw5YS83kH1Y+/RcqqCMHYpeEuW4blonOKhrGnc3UAD8AiOqAH7T2VhHKNSSu
         FU8Sb5ClVfxIUkx7BLkk3bSFT/hjd6kZs6TMH/7swHrkRGATL+6HQPecbs28qC6OI9O9
         QX1/GVOdD3bzptKLcMZTQyYo1QQWAfacIKhj4CeaJl0yX39+3yCUBKLdrCmrJv7mDczX
         Gryw/6YolbCC9vDxvAfyAd6mQZNoSZzRVr5Ds+rk4z23XONPMAlO9szPr3AtlhoarZyX
         YQWzvNaVmVRvim1qKUfiGxYQoXB2cPeEeK4VQIQaLjRs+LHcxWzFxA9lRd7R1mRZqVMP
         dSCw==
X-Gm-Message-State: AOAM530Q7pFozKNmSsgbdsXR5xIL7K/Fx6ZqVHN2MH1RjJzKIBzv8TVV
        QyA2lzbg9RSC48l3IOc4dVQ=
X-Google-Smtp-Source: ABdhPJxntKrDrssV9OMT2JGVH7NlNv60SyDFdFr59BZ7NlXVQDM5jg0qyGKQb+MGLXLF77MqfDwlHw==
X-Received: by 2002:a17:90a:5797:b0:1bc:56a9:f6c8 with SMTP id g23-20020a17090a579700b001bc56a9f6c8mr14210781pji.12.1646452929450;
        Fri, 04 Mar 2022 20:02:09 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id j6-20020a056a00174600b004f3e5d344b9sm7575041pfc.194.2022.03.04.20.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 20:02:09 -0800 (PST)
Date:   Sat, 5 Mar 2022 04:02:03 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm/sl[au]b: unify __ksize()
Message-ID: <YiLgu4zG+rLonf9c@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-3-42.hyeyoo@gmail.com>
 <74269fcd-60ef-5308-3aaf-e8944e37d1b0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74269fcd-60ef-5308-3aaf-e8944e37d1b0@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:25:47PM +0100, Vlastimil Babka wrote:
> On 3/4/22 07:34, Hyeonggon Yoo wrote:
> > Now that SLAB passes large requests to page allocator like SLUB,
> > Unify __ksize(). Only SLOB need to implement own version of __ksize()
> > because it stores size in object header for kmalloc objects.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> As discussed, we can be more specific about the !folio_test_slab() case, but
> that can be done on top.

I'll add that in v3. Thanks!

-- 
Thank you, You are awesome!
Hyeonggon :-)
