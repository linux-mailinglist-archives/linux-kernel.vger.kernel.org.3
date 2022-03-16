Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2451B4DA6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350647AbiCPAlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:41:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0985DA50
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:40:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so973674ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcXfDqdleD8jWRkbjV0N05nVuHrGssQckvhHUoq/WGg=;
        b=b6v4jP7umY5sxN1xiUDoa2fQsh07jDAZyO21Re1xdf3cfz7Q+8PgnZzCpegZuhfdq8
         0YGaKGzCWYqhIRQ/giUDQVOy16dmC5vSaInv1zo18ohyY0mcvGljLHfXlctCWVg11giG
         m46U/dCZmoRzE4rtfdCu7egnxLmq9gxG4P2muzXZ78oY1Vtnmy6ZS+3D9ChVWLXDwtZD
         tQIUqbFRBjJWEsN3YVOeMyiVNpl1sv5LAjmp4W/8q/D1cOAkBOCFVYGzcSFVOFYn+n1m
         eE6oPu97NscIPoFEX/hymDZ0hB9KP6a/Xq38trd9h6Yq65G+6eylN52gsvUAXsrXiEJx
         ZNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcXfDqdleD8jWRkbjV0N05nVuHrGssQckvhHUoq/WGg=;
        b=KOSeBxctZR3yiEgG0wUh0PQIGTMp0Aqszgg3oGTPzoZ18cyLb8dPtqchvOjIgWKMHR
         B5Ew7BcnwaIr+cw9JJg+KXGwf6GMKeyvkbBoEkYci5dKbj/DRMCNA0def1x+aoYbtKmS
         gPXuJ/vDfCi8uh6mGSES0UdnQMlbTHW3JFQgZZir7ryPStbOmV4fNEriWjxv8nvtvxU6
         3b7eqjZfv+BY3NWukxqVi6RAX7iF/RwIfXRs1kmzKGHLcLA+2iEmvdlGPQAq1KIO9Utf
         DWq0Wn5cUyp8cL38xO8pTIAlN5DNf3rnqmX09yZq9nhu1Pw6vhXzxMBUs9bN9eTCzAAi
         zJCg==
X-Gm-Message-State: AOAM530OG7p2xj6xz7xX4PtfgKQgNBH6cuJL+iFJOIwky8Sa2SoYJitH
        uURpPM5NPcPUSFgw/tn90Gs=
X-Google-Smtp-Source: ABdhPJyB8TZPF7GedEWQFY85EvkH8ScFmNgsBmhQ7UfXDVS1FOCy6Tr2NqG2s1CPSH4I5VxveimHyA==
X-Received: by 2002:a17:906:d555:b0:6da:ac8c:f66b with SMTP id cr21-20020a170906d55500b006daac8cf66bmr24317533ejc.107.1647391209681;
        Tue, 15 Mar 2022 17:40:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906778700b006df7e0e140bsm15578ejm.140.2022.03.15.17.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Mar 2022 17:40:09 -0700 (PDT)
Date:   Wed, 16 Mar 2022 00:40:08 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/page_alloc: add zone to zonelist if populated
Message-ID: <20220316004008.kzmhzduqdwqyke5l@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220203020022.3044-1-richard.weiyang@gmail.com>
 <Yfuf759naxpCeSx2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfuf759naxpCeSx2@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:27:11AM +0100, Michal Hocko wrote:
>On Thu 03-02-22 02:00:22, Wei Yang wrote:
>> During memory hotplug, when online/offline a zone, we need to rebuild
>> the zonelist for all nodes. Current behavior would lose a valid zone in
>> zonelist since only pick up managed_zone.
>> 
>> There are two cases for a zone with memory but still !managed.
>> 
>>   * all pages were allocated via memblock
>>   * all pages were taken by ballooning / virtio-mem
>> 
>> This state maybe temporary, since both of them may release some memory.
>> Then it end up with a managed zone not in zonelist.
>> 
>> This is introduced in 'commit 6aa303defb74 ("mm, vmscan: only allocate
>> and reclaim from zones with pages managed by the buddy allocator")'.
>> This patch restore the behavior.
>
>It has been introduced to fix a problem described in the the changelog
>(FADUMP configuration making kswapd hogging a cpu). You are not
>explaining why the original issue is not possible after this change.
>

After some reading, here is what I find.

To prevent this problem again, we need to make sure reclaim only applies to
managed_zones. After go through the code, there are only two places we don't
guarantee this when iterating zone.

  1. skip_throttle_noprogress()
  2. throttle_direct_reclaim()

After we make sure vmscan only reclaim on managed_zone, the problem won't be
possible after this change.

BTW, there are another two places use for_each_zone_zonelist_nodemask(). It's
ok to not check managed_zone, since actually they are doing a node base
iteration.

If this looks good to you, I would adjust the changelog and send two patches
to fix the above two places.

>I also think that this is more of theoretical issue than anything that
>is a real life concern. It is good to state that in the changelog as
>well.
>
>That being said I am not against the change but the changelog needs more
>explanation before I can ack it.
>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Mel Gorman <mgorman@techsingularity.net>
>> CC: David Hildenbrand <david@redhat.com>
>> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
>
>Fixes tag should be really used only if the referenced commit breaks
>something. I do not really see this to be the case here.
>
>Thanks!
>

-- 
Wei Yang
Help you, Help me
