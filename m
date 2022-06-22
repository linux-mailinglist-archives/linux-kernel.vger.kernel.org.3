Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281115548E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiFVIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFVIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:54:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345733E88
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:54:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d129so15516181pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NPz6aysJ4lKE5JHLkll4+SwUhp9oiQCtyExa/aZASL4=;
        b=t8+Nm/Nm3fXHIky43hvB+9u58dnsstVeJtDa1cLpnYXi3KWOTWJz9oC0BVaeFQB+ge
         mtdYrumXWF5Lr6HmweRlNPE1tDXUKb+tj8tT2BeJoyl4uKUK6fc3JCnCZTD7C87gqKTx
         GO+0JsZnSnzpyuc+rLCfG1Ek4tUtEWC62rGye6AGP3UvKsyajg8FS7uHZqMc7W90I8ZM
         hWfWwo1gp9RlFLdW2W3ApzWN9o2kHzFIczO6MzuT8b04PIDl4n9BL6eu7MACppiaA8xk
         AKZ1UPPELrH8bHYsgRZPJzT8EdtqN5RQ7L7rDPhyq/L2lhtB/eksIqnXQHMKKreH2W2Q
         jXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPz6aysJ4lKE5JHLkll4+SwUhp9oiQCtyExa/aZASL4=;
        b=Se/fBSCaHJjRUXXLgiJM4xQx7sRfQEl+m8d7tsivIInPEVOGMUHXRQpDQnBI0ctVCg
         czu1+gbXy0CHvCYQMjRXqJFhLhT+NMqhUebMMo1OX9RHgZg1MUWvU7vp/kXzo0Gxlp89
         3Ool4lx5uKYZ67v2GuaIlxWtIj7ILC4JMiQ4yzKenZxrizGJoZql28RNCXewy7hN8+qP
         f4K/92jG4w1HL251+eczYJZjSDn452xgQR5Xk/GZJwOm5sVwnBYUAypDS2IN3393b/Wl
         YToKR9nqhQnQLyQ8vAQwL5Y33PlvDOajCIfcl9NaaCJ3HxxzHKqnUK2N9/1AeNMsiSzo
         lshQ==
X-Gm-Message-State: AJIora+D4Jv+Z55l27aTNwfYo+nIGFk+M0zA3CIkYNPsBV95usser4cu
        u9ayq6lOz0qtQMynZXyuJcHAag==
X-Google-Smtp-Source: AGRyM1uo0P4pX8SHoZRe2EUDrLwxiOIPYCP6UvpzcVZkKBOhowttVZ9N680TUQINuxLGzg8z8AUNDA==
X-Received: by 2002:a05:6a00:1a09:b0:525:a0d:d1d3 with SMTP id g9-20020a056a001a0900b005250a0dd1d3mr21848009pfv.27.1655888089663;
        Wed, 22 Jun 2022 01:54:49 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b00163f3e91ea0sm1641513pln.238.2022.06.22.01.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:54:49 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:54:46 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total
 pages and memmap pages when empty
Message-ID: <YrLY1ru0qrvZfqU2@FVFYT0MHHV2J.usts.net>
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-2-osalvador@suse.de>
 <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
 <YrKQyhwDwMvueOUc@localhost.localdomain>
 <YrKS6aFHKRyZzAwi@FVFYT0MHHV2J.usts.net>
 <bb71d77e-583a-d216-1aae-2bc062318888@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb71d77e-583a-d216-1aae-2bc062318888@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:31:12AM +0200, David Hildenbrand wrote:
> On 22.06.22 05:56, Muchun Song wrote:
> > On Wed, Jun 22, 2022 at 05:47:22AM +0200, Oscar Salvador wrote:
> >> On Tue, Jun 21, 2022 at 09:44:47AM +0200, David Hildenbrand wrote:
> >>>
> >>>
> >>> It's worth noting that the check in pgdat_is_empty() is slightly
> >>> different. I *think* it doesn't matter in practice, yet I wonder if we
> >>> should simply fixup (currently unused) pgdat_is_empty().
> >>
> >> I guess we could change it to
> >>
> >>  static inline bool pgdat_is_empty(pg_data_t *pgdat)
> >>  {
> >> 	 return node_start_pfn(pgdat->node_id) == node_end_pfn(pgdat->node_id)
> >>  }
> >>
> >> ? And maybe even rename it to to node_is_empty (not sure why but I tend to like
> > 
> > At least I like this name (node_is_empty) as well.
> > 
> 
> Let's try keeping it consistent. I think node_is_empty() might indicate
> that we're punching in a node id instead of a pgdat.
>

I suspect Oscar will change the argument to "nid" as well, like:

static inline bool node_is_empty(int nid)
{
	return node_start_pfn(nid) == node_end_pfn(nid);
}

Does this look good?

Thanks.
 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
