Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE455125A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiFTIQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiFTIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:16:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C811A00
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:16:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m14so9083491plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJp6zKznVxJfr/RIAJgVAJ+nrHEi1khVAw0YLkdycUQ=;
        b=DzyUJyKdeGFOBC8Unr++TcCO5dXrnJ+fYaP+KN9WlW9ERU+P6aHcqptCKD8sgTnOvR
         oL6TL9y2reMi0lMHvuA25QAzfdBCl8Q/H7kBqMyGqxE13N5p4aL/8ip8yTcIYCnnF8sz
         jBcWsvfvHgJzlqtCRbyVQklt3UgvbL0smm2MQXJJT88pJXmNnMqAntaX8k3E0vfsjplS
         5krzn3MxdueBqC1mbN1JhYIfruvr7QlFe4N748k684liDHV1mI+8Tpy+sFAcXh27tHqT
         afFGa3NN6EoEs2yhpGF5oB2jLtaoZ/9ep09adrKeN5ZG0sKBDWGpl24SlqmDOHAWr//S
         ERIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJp6zKznVxJfr/RIAJgVAJ+nrHEi1khVAw0YLkdycUQ=;
        b=Oao14wwEiw1jaVZ6YJDF94SoKEEn+/UT+ybXgZbCFwFcqE1XEkETSrxxWwfSpZfCl7
         bQ2ZiswBNh7O6j8cIEeyH1YgtMdKn0ny1I8FsM6u6GK1Kp6aw5x4917xKqU1rjCuWFwx
         KsjIDbp4Uz2tGTqaK9EQ4G7ARR7kv5ZUxdWS0x6nOAPKw31uo6Iq765iKdi9ur2IlmyT
         SQ71h71HLEDx1SIMeCxJvWmxOKlIBkNQpZZAiRdP4mI4SBDbr7fscy/SKlC4TQiz+9Hm
         6SF46KFR9cUynim0aqYwv1H6/XNGkc45ev/X7X+gPG1XY4EgKUOwyo6tmqibnPEnaFuL
         Df2A==
X-Gm-Message-State: AJIora9cHw5X0cuT77AfD50m/DTVLbI3jHmlzgcY97ugRY8iqdf1kbkR
        SzVJymLA4D+n1bd+an8LjptkBw==
X-Google-Smtp-Source: AGRyM1to4IBp7cxwKHCra4hlixnkJdjNU0aF5w+RquhujBSRx+ojyuZwkR0v4knU9iVfph2gRCDy6g==
X-Received: by 2002:a17:902:e745:b0:168:e68e:fab8 with SMTP id p5-20020a170902e74500b00168e68efab8mr22472556plf.23.1655712984926;
        Mon, 20 Jun 2022 01:16:24 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a780900b001ead46e77e2sm7648819pjk.13.2022.06.20.01.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:16:24 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:16:20 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, mike.kravetz@oracle.com,
        osalvador@suse.de, paulmck@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v4 1/2] mm: memory_hotplug: enumerate all supported
 section flags
Message-ID: <YrAs1LGbExHI/mcw@FVFYT0MHHV2J.usts.net>
References: <20220619133851.68184-1-songmuchun@bytedance.com>
 <20220619133851.68184-2-songmuchun@bytedance.com>
 <b3226af2-5d19-5377-9072-179388cb2609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3226af2-5d19-5377-9072-179388cb2609@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:51:42AM +0200, David Hildenbrand wrote:
> On 19.06.22 15:38, Muchun Song wrote:
> > We are almost running out of section flags, only one bit is available in
> > the worst case (powerpc with 256k pages).  However, there are still some
> > free bits (in ->section_mem_map) on other architectures (e.g. x86_64 has
> > 10 bits available, arm64 has 8 bits available with worst case of 64K
> > pages).  We have hard coded those numbers in code, it is inconvenient to
> > use those bits on other architectures except powerpc.  So transfer those
> > section flags to enumeration to make it easy to add new section flags in
> > the future. Also, move SECTION_TAINT_ZONE_DEVICE into the scope of
> > CONFIG_ZONE_DEVICE to save a bit on non-zone-device case.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/mmzone.h | 44 +++++++++++++++++++++++++++++++++++---------
> >  mm/memory_hotplug.c    |  6 ++++++
> >  mm/sparse.c            |  2 +-
> >  3 files changed, 42 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index aab70355d64f..932843c6459b 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1418,16 +1418,35 @@ extern size_t mem_section_usage_size(void);
> >   *      (equal SECTION_SIZE_BITS - PAGE_SHIFT), and the
> >   *      worst combination is powerpc with 256k pages,
> >   *      which results in PFN_SECTION_SHIFT equal 6.
> > - * To sum it up, at least 6 bits are available.
> > + * To sum it up, at least 6 bits are available on all architectures.
> > + * However, we can exceed 6 bits on some other architectures except
> > + * powerpc (e.g. 15 bits are available on x86_64, 13 bits are available
> > + * with the worst case of 64K pages on arm64) if we make sure the
> > + * exceeded bit is not applicable to powerpc.
> >   */
> > -#define SECTION_MARKED_PRESENT		(1UL<<0)
> > -#define SECTION_HAS_MEM_MAP		(1UL<<1)
> > -#define SECTION_IS_ONLINE		(1UL<<2)
> > -#define SECTION_IS_EARLY		(1UL<<3)
> > -#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
> > -#define SECTION_MAP_LAST_BIT		(1UL<<5)
> > -#define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> > -#define SECTION_NID_SHIFT		6
> > +enum {
> > +	SECTION_MARKED_PRESENT_BIT,
> > +	SECTION_HAS_MEM_MAP_BIT,
> > +	SECTION_IS_ONLINE_BIT,
> > +	SECTION_IS_EARLY_BIT,
> > +#ifdef CONFIG_ZONE_DEVICE
> > +	SECTION_TAINT_ZONE_DEVICE_BIT,
> > +#endif
> > +	SECTION_MAP_LAST_BIT,
> > +};
> > +
> > +enum {
> > +	SECTION_MARKED_PRESENT		= BIT(SECTION_MARKED_PRESENT_BIT),
> > +	SECTION_HAS_MEM_MAP		= BIT(SECTION_HAS_MEM_MAP_BIT),
> > +	SECTION_IS_ONLINE		= BIT(SECTION_IS_ONLINE_BIT),
> > +	SECTION_IS_EARLY		= BIT(SECTION_IS_EARLY_BIT),
> > +#ifdef CONFIG_ZONE_DEVICE
> > +	SECTION_TAINT_ZONE_DEVICE	= BIT(SECTION_TAINT_ZONE_DEVICE_BIT),
> > +#endif
> > +};
> 
> I can understand the reason for the other enum, to auto-assing numbers.
> What's the underlying reason for the enum here? Personally, I'd just
> stay with defines, so I'm curious :)
>

Oh, just my personal preference. I can replace those with defines in
next version if you prefer it. :-)

Thanks.

> LGTM
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
