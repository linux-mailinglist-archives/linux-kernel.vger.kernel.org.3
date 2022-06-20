Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A44551F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiFTO6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiFTO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:57:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F831559F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:20:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u37so10369212pfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J0C2HHsbOQSXfYAryP7A5YBKSGtDJBQq/a2915IoEXg=;
        b=tEPR2uts4ypvF3V0L7HGkn58uuvfZFTYbnas3kFCboi3LOGlOxKaa5q7HLVYiRzQq8
         GxzbxWLit6Xdj5G4CUrPpzeCgbRbCnSfEcd+7k6tl/iUuDOSO7q83552eZ5U43f6sCOc
         13l5POTPPKlGt8sRtRF47+dEnPX2bqRTYpgypMtEBTFYRNV697u0w467EKldQ7wrQXnO
         1+pKc0zw2KSf7wh9r8A2ASxyQ5N/sZj3qY1f8LwWTxCLxNeWadmLolUWqlT3CX7gQ3My
         MuodctXcQSEuD6+Bc7PDXie0G/JQX9MQx0X8NmazazywSzi6wO5IyYZnAoUaxXlwUsGM
         jaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0C2HHsbOQSXfYAryP7A5YBKSGtDJBQq/a2915IoEXg=;
        b=2ovrn1xJGKpzBkA9ciADU+a2qZ+JmLFVZxeRCgjMLtGJe8M6BDPnkbxI6O6a57wdcm
         4/i3trjr/5v1wwAe5Aa/r22eMRRCuFWZEhU9/Hkm/YiOnJxAJSjeoDAFy7RqCvyCZ8ps
         GLcaEd+IGqdoyVyVB/oqkWwJZNNHgm01r0PIXwt6g/FZjCFcx9WHDZScNCeYSVzYgKcz
         W2CUL+Ywn80jsdJdCsLnBfPGvWoFLk7i7eTdnyTeotDwEekPMOx3lP7ZYDMC5eYYb94r
         eP/bWqbyihMEgjeLe0bEQiKsK+f9axKiPxaM8W1uCkrK0YJghMyf4UKV8tjGTOhptYvn
         OnWg==
X-Gm-Message-State: AJIora9RLTTIT4nbNttxCjVp6HsPOEibwEDjOTkCbsSYTRpD+tNVQlLq
        l08go8XnN5WMU0jhMQrQEzrd7w==
X-Google-Smtp-Source: AGRyM1toe+QYeMNfOIaXcAkjR7ZUQ3qcCY/dhFUqc4mi1yEH+v5CjC8N0Qn8/mR7HEDUAUsNWS6kzA==
X-Received: by 2002:a62:3145:0:b0:525:1309:36f8 with SMTP id x66-20020a623145000000b00525130936f8mr11479093pfx.74.1655734811846;
        Mon, 20 Jun 2022 07:20:11 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a8d0300b001ec84049064sm4896427pjo.41.2022.06.20.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:20:11 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:20:07 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <YrCCFwgoLKhDn7Fo@FVFYT0MHHV2J.usts.net>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
 <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
 <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
 <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com>
 <YrB6R5uHQaz1adhK@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrB6R5uHQaz1adhK@qian>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:46:47AM -0400, Qian Cai wrote:
> On Mon, Jun 20, 2022 at 08:32:27PM +0800, Miaohe Lin wrote:
> > >>>>> --- a/mm/swapfile.c
> > >>>>> +++ b/mm/swapfile.c
> > >>>>> @@ -2646,7 +2646,7 @@ static int swap_show(struct seq_file *swap, void *v)
> > >>>>>  	}
> > >>>>>  
> > >>>>>  	bytes = si->pages << (PAGE_SHIFT - 10);
> > >>>>> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
> > >>>>> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
> > >>>>>  
> > >>>>>  	file = si->swap_file;
> > >>>>>  	len = seq_file_path(swap, file, " \t\n\\");
> > >>>>> @@ -3265,7 +3265,7 @@ void si_swapinfo(struct sysinfo *val)
> > >>>>>  		struct swap_info_struct *si = swap_info[type];
> > >>>>>  
> > >>>>>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> > >>>>> -			nr_to_be_unused += si->inuse_pages;
> > >>>>> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
> > >>>>>  	}
> > >>>>>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
> > >>>>>  	val->totalswap = total_swap_pages + nr_to_be_unused;
> > >>>>
> > >>>> READ_ONCE() should be paired with WRITE_ONCE().  So, change the writer
> > >>>> side too?
> > >>>
> > >>> READ_ONCE() is used to fix the complaint of concurrent accessing to si->inuse_pages from KCSAN here.
> > >>> The similar commit is 218209487c3d ("mm/swapfile: fix data races in try_to_unuse()"). IMHO, it's fine
> > >>
> > >> I think the fix 218209487c3d is incomplete. The write side in swap_range_free() should
> > >> also be fixed. Otherwise, IIUC, it cannot stop KCSAN complaining.
> > > 
> > > I tend to agree with you. READ_ONCE() should be paired with WRITE_ONCE() theoretically. But WRITTE_ONCE()
> > > is ignored while the commit is introduced. Add Qian Cai for helping verify it. It's very kind of @Qian Cai
> > > if he could tell us whether WRITTE_ONCE() is ignored deliberately.
> 
> The write side should be protected by the lock swap_info_struct::lock. Is
> that not the case here?
>

The lock does not protect the read sides. So the write side should be
fixed by WRITTE_ONCE().

Thanks.
 
