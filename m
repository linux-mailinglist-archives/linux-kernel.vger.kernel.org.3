Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF65999E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347897AbiHSKeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348029AbiHSKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECB03DF2A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660905246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9qConcsVrFeMSKZiZOZ7jvIr/WxjYXLhBQh/vLaFNc=;
        b=aV6M06N4NgBlzmkUp4MMxNRa0koCQ4xdcPTbMhczatmB15nDwq6rEdyu79R530s2grjbHw
        EhxFMFCcpdDe/d5puVDl2W5uhSr0NheUvNeYzl8qcG7IJAxgqEG8Fj75WXfVYMFYyzyFDs
        GkXTWHJjP1QyWBlcCSYY9qs6G4oI3TQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-gw1IjTYaMiOC1HI27ccfFw-1; Fri, 19 Aug 2022 06:34:04 -0400
X-MC-Unique: gw1IjTYaMiOC1HI27ccfFw-1
Received: by mail-wr1-f70.google.com with SMTP id o13-20020adfba0d000000b0022524f3f4faso641173wrg.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=t9qConcsVrFeMSKZiZOZ7jvIr/WxjYXLhBQh/vLaFNc=;
        b=f1R2Gw63r6OhH3RA0JUs+KdQYlMwMMvpCmrIZ/Lg1AuioDfVpSE5r7D2n3UFRn/9zQ
         lRiJ60zLLBAtngMwa3oIssF68Cu/wUM4WjHCqZ49Rp+XWmFeuUcnTuaEp0DyZzPFVujo
         RppNFbuT0tyyFf6U90Q586/3MjktPqehqsaWggcMdxrKiM1WakwbxxBJAtSzvoUKlPTW
         Y073QiWWpCqgAgiVPX+F6sqONTRpM1YbeMJpzgRh4jxWGuusRQWZToXRv3oYs3+Jt632
         oxcihg+BiKykkGkwD5XSrbuzs0QKJskDyKbp7+OOOwNTl0D1Wsy9kR2wtJTqkxqeGb/L
         I9nQ==
X-Gm-Message-State: ACgBeo3u0M3eyBdwi5cjJnS/26tD723oSu4X5p4QpnHWi9RLYP+q5ve8
        e+W5JThJ0GV7scxzpFry+cXhxo1k318ojuzQhDwBCsI89aXinn6n/3GPUvjfF47jgaWXilqtWf7
        ORCS3A7NamE1oGgrX0jZqmC7W
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id g9-20020a5d64e9000000b002207dd763ebmr3831675wri.590.1660905243397;
        Fri, 19 Aug 2022 03:34:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AoX+VQs/b3XMThsgV+BYuePZtBIHhF6hh6s7w1xBiDvXh8zDLXmM78RPTeY/EF0PqfZ3SJQ==
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id g9-20020a5d64e9000000b002207dd763ebmr3831663wri.590.1660905243244;
        Fri, 19 Aug 2022 03:34:03 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b18-20020adff252000000b00224f605f39dsm3501436wrp.76.2022.08.19.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:34:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev <netdev@vger.kernel.org>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 1/5] bitops: Introduce find_next_andnot_bit()
In-Reply-To: <CAHp75VcaSwfy7kOm_d28-87QKQ5KPB69=X=Z9OYUzJJKwRCSmQ@mail.gmail.com>
References: <20220817175812.671843-1-vschneid@redhat.com>
 <20220817175812.671843-2-vschneid@redhat.com>
 <20220818100820.3b45808b@gandalf.local.home>
 <xhsmh35dtbjr0.mognet@vschneid.remote.csb>
 <20220818130041.5b7c955f@gandalf.local.home>
 <CAHp75VcaSwfy7kOm_d28-87QKQ5KPB69=X=Z9OYUzJJKwRCSmQ@mail.gmail.com>
Date:   Fri, 19 Aug 2022 11:34:01 +0100
Message-ID: <xhsmhk074a5eu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/22 22:04, Andy Shevchenko wrote:
> On Thu, Aug 18, 2022 at 8:18 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Thu, 18 Aug 2022 17:26:43 +0100
>> Valentin Schneider <vschneid@redhat.com> wrote:
>>
>> > How about:
>>
>> >
>> >   find the next set bit in (*addr1 & ~*addr2)
>>
>> I understand the above better. But to convert that into English, we could
>> say:
>>
>>
>>   Find the next bit in *addr1 excluding all the bits in *addr2.
>>
>> or
>>
>>   Find the next bit in *addr1 that is not set in *addr2.
>
> With this explanation I'm wondering how different this is to
> bitmap_bitremap(), with adjusting to using an inverted mask. If they
> have something in common, perhaps make them in the same namespace with
> similar naming convention?
>

I'm trying to wrap my head around the whole remap thing, IIUC we could have
something like remap *addr1 to ~*addr2 and stop rather than continue with a
wraparound, but that really feels like shoehorning.

> --
> With Best Regards,
> Andy Shevchenko

