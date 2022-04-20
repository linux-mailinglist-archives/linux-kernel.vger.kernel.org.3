Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E150896C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356873AbiDTNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353397AbiDTNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FD871D331
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650461562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3MgJiiCpC3oIJlTcptz7g4sdjvu/V+8X1Bh4oqWn0GQ=;
        b=VULOMg795ayW4BHmyBq4/Kfzk1XKKI7lyiC0QayIjfUMkRBK74OjwPw1M5x2w0WZTaQ4sg
        IWjRgUS3kt4nuqwOIHLjB8iVNlLB36sPC4Vrm/QR+7yLBb2nhR+dIWXzT+auOFP8tBCV2y
        GUTHRiF3q1F3/CAgOtFKPPHuOD4Eq94=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-AVD0i1bGPuC67XYjg6o6Ug-1; Wed, 20 Apr 2022 09:32:41 -0400
X-MC-Unique: AVD0i1bGPuC67XYjg6o6Ug-1
Received: by mail-il1-f200.google.com with SMTP id v11-20020a056e0213cb00b002cbcd972206so910865ilj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MgJiiCpC3oIJlTcptz7g4sdjvu/V+8X1Bh4oqWn0GQ=;
        b=ATk+uHZPdK3mfqKTAovU/UjTtJ+Ba6KtB6qveoA3ddfxHq8kKrJsayB9M/fk/1CqZz
         28Av54MHMNb3eQnohDW31hV6pt1bg+QClfOP37E+IScmi8ZFmayKBcMlwI0ccBvFdotL
         NnhSo/fLGrho81ckqivaYFGT/4mUTF9+e2n51j1ZW8OmZYOmiNdiJMqc2/PGM2wrcBJY
         MdfKkKVRhLSeR1dtj4bhWSL2FLg264957s7wIvd0KkYIAdRZi14sHqsvIKA3Xe2KHHSB
         19TQsN5Anbmp9MbCecUn7I+QSnRMZJoV4iJRyGcOIlO+2ykJjAhsu1pIFxX9lhtCCmOF
         jUPg==
X-Gm-Message-State: AOAM531e9+FORBtXxYevT3OYlLdeOhdbiDeBlvljdsFhQX+6Oy0vjh1J
        fyMGrRcSwXJCi8d0lb84pvG8JD3ot11cKVihpDn8/Y+l0AfyuFij2p6Zf9zbiRoRj3qQjbSPa5M
        yBymXK4UZ0wi7SoxR5q2Yj2E+
X-Received: by 2002:a05:6602:2a47:b0:649:ee6f:c5e1 with SMTP id k7-20020a0566022a4700b00649ee6fc5e1mr8927235iov.91.1650461560707;
        Wed, 20 Apr 2022 06:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxbD8sUedy0Kg1XMhNrWWoYZRKB7/yobBvP9IYOO+qywfy89teUSdYwAemjcGGbdg37ZNEQw==
X-Received: by 2002:a05:6602:2a47:b0:649:ee6f:c5e1 with SMTP id k7-20020a0566022a4700b00649ee6fc5e1mr8927224iov.91.1650461560490;
        Wed, 20 Apr 2022 06:32:40 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a3-20020a5ec303000000b006496b4dd21csm11386663iok.5.2022.04.20.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:32:39 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:32:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        apopple@nvidia.com, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Message-ID: <YmALdt9MV2MI9FRp@xz-m1.local>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <Yl8rZkhU/B0iE2ob@xz-m1.local>
 <8e01e276-c956-2486-c55f-c689f33a9106@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e01e276-c956-2486-c55f-c689f33a9106@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:21:27PM +0800, Miaohe Lin wrote:
> On 2022/4/20 5:36, Peter Xu wrote:
> > On Sat, Apr 16, 2022 at 11:05:49AM +0800, Miaohe Lin wrote:
> >> @@ -1797,6 +1797,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> >>  		goto out;
> >>  	}
> >>  
> >> +	if (unlikely(!PageUptodate(page))) {
> >> +		pte_t pteval;
> >> +
> >> +		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >> +		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
> >> +		set_pte_at(vma->vm_mm, addr, pte, pteval);
> >> +		swap_free(entry);
> >> +		ret = 0;
> >> +		goto out;
> >> +	}
> >> +
> >>  	/* See do_swap_page() */
> >>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
> >>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
> > 
> > Totally off-topic, but.. today when I was looking at the unuse path I just
> > found that the swp bits could have got lost for either soft-dirty and
> > uffd-wp here?  A quick patch attached.
> 
> Am I supposed to test-and-send this patch? The patch looks good to me except the
> build error pointed out by kernel test robot.

I was planning to post a patch after yours since they're touching the same
function, but yeah it'll be great if you could also take that over, thanks!

-- 
Peter Xu

