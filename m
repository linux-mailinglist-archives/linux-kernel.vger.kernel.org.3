Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369675204EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiEITII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiEITIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EED97297425
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652123052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4c+bANNOi4sApJZ1cTVk45/N0JeRAadFfeHChP/lKJw=;
        b=FR1uU/BUe+Yn/h4OhpLtvQcjSJ5s8f7R6ThZf7O0o0nNT5Y3YFZ5Jssp84nOwH+v9ib968
        /ATJ6bdxiIkHfp91/Pdd2NgTK+PMv87g8ZmQ2212076wJq8hxCxjnakLcYN9w/ZziVHDk6
        LUE/KLH+xEmq5bpJW4Ox1kXggm+MgZg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-hIC0xsORNw2FGyvjvAYPjQ-1; Mon, 09 May 2022 15:04:10 -0400
X-MC-Unique: hIC0xsORNw2FGyvjvAYPjQ-1
Received: by mail-ed1-f69.google.com with SMTP id r26-20020a50aada000000b00425afa72622so8760852edc.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 12:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4c+bANNOi4sApJZ1cTVk45/N0JeRAadFfeHChP/lKJw=;
        b=L9MCrIjPeRli8ITf6Slkb10eQPX18dmTdTSaEvggDIm20wcC91Brq7v1soVuydVh8G
         STXNyYdfvxITeoOP9dEqqzQTwpZPDLwYWzrJxBXLyj//OT8SE5AOi5QQw8sK8Xu/fpZG
         d5kxolw/qZlqxL36LGovWPY8eDbAlM5nlo4dXDG6/I917SP6TilAKex5LBrIiFaShge6
         GRPc/YECKoLOuoHwSOFhjEMA0Lp0e94JNSXDC/PgOM9dVjMEamUDrvqmuIoWvyOpb0bJ
         KcXRN1plwVCPdTGeqJ+LzL3jHsJ8mHZVULeIZRMFIGngaB9AZwbCCFP5CqsymS5WkX4o
         auFA==
X-Gm-Message-State: AOAM530N0vq3xpKuq3hnUJWCZAVph5H/OIReE0sYOJqy2Wwzs9emCewQ
        tHl+aHVEImtalkDeMs9Y5zckwt7++xXikq+TAIiXUi7TNeyzpB2huEReoinUn2dgcHiOqaYVTwg
        7r6J+UuNdh6VEnpMY4nrQ8xLW
X-Received: by 2002:a17:907:2ce6:b0:6f4:7e8e:af40 with SMTP id hz6-20020a1709072ce600b006f47e8eaf40mr15521395ejc.211.1652123049424;
        Mon, 09 May 2022 12:04:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnHAgNoRkHPDpX0mV6CZQzXr55+KlJweOT0EUsiyDdB6Wa4kFRNLe0wYZ20i6JowEuwIgfjQ==
X-Received: by 2002:a17:907:2ce6:b0:6f4:7e8e:af40 with SMTP id hz6-20020a1709072ce600b006f47e8eaf40mr15521374ejc.211.1652123049157;
        Mon, 09 May 2022 12:04:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id w7-20020a170907270700b006f3ef214e49sm5380213ejk.175.2022.05.09.12.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 12:04:08 -0700 (PDT)
Message-ID: <54664f6a-b046-1330-e794-cb533e942a94@redhat.com>
Date:   Mon, 9 May 2022 21:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Linux regressions report for mainline [2022-05-09] (was: Linux
 5.18-rc6)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
 <165209064657.193515.10163777181547077546@leemhuis.info>
 <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/9/22 19:20, Linus Torvalds wrote:
> On Mon, May 9, 2022 at 3:47 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> Hi Linus! Here's a quick compilation of open reports about regressions in
>> 5.18-rc that I'm currently aware of; most of the reports are quite
>> recent and there afaics is nothing that looks particularly worrisome.
> 
> Well, the Intel GPU issue seems likely to cause problems for lots of people:
> 
>> [ *NEW* ] drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
>> -----------------------------------------------------------------------------------------
>> https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>> https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>
>> By Hans de Goede; 0 days ago; 2 activities, latest 0 days ago.
>> Introduced in b5cfe6f7a6e1 (v5.18-rc1)
>>
>> Recent activities from: Tvrtko Ursulin (1), Hans de Goede (1)
> 
> Although it looks possible that it mainly affects old chipsets (ie the
> two reports are for a Bay Trail chip and a Core 2 Duo chip - I have no
> idea how they compare).
> 
> That probably means there are a lot of machines out there, but likely
> not the kind that most kernel developers will be testing, so not a ton
> of reports until it hits distro kernels etc.
> 
> It looks like Maarten is already involved.

This is being tracked here:
https://gitlab.freedesktop.org/drm/intel/-/issues/5806

I've just tested a patch from Maarten which fixes things for me,
so hopefully we can get this resolved soon.

Regards,

Hans

