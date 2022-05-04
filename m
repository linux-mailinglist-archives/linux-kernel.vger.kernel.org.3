Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8589E519C09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiEDJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiEDJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC0C82655A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651657072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6g2UJy+0nwhmO5/tF8oPdW8Lnfz1wSfTmKwEMghbcA=;
        b=T/VXQNCPNAdlx4RkVdgXv17XMb38Cx9VrRlHQUIG7gayHM8kBQ9SRSZXTRrxrT6L4Uc9iH
        bWUJu3N5K4IKdhQHT8myWTtaYeoFzWvRCajyWBjW2IrlMIwZ6NtTWix9isfKs/3p6g66iS
        A0HTYkqqY6nMQsyZb5Bwn12w1bO8VOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-cYQkRTP8PcGROPRa6OaIdg-1; Wed, 04 May 2022 05:37:52 -0400
X-MC-Unique: cYQkRTP8PcGROPRa6OaIdg-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso2747017wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6g2UJy+0nwhmO5/tF8oPdW8Lnfz1wSfTmKwEMghbcA=;
        b=fc8USh/qqb4uW+JNY1qXXP4S4vO7biXjWnOZu3HQVi6IrBenM2OA0fXZpGNdGBWnzT
         8MoJMSyYDnYX8UxF7+VGC2wnAX4AmDkF8keMuC9xL2KfHbt1BsOfODmgq3b1E4Hj1Nq+
         I7tbxTMOjNe/roQf19C3Ogj7en+7Oto70nzJ9GBphzcxA3dKEUTVICMJmA5SdEKEFMC/
         AgHXgGaQXETU+F51lGZ8squxUMvhs013lBCN8A8xGFBE1d8wiIe0a7FHY4tHWo1MRG7b
         kOl84qhftW7NkSWfbPx/t35TM7ZocqT274Y9esCyAfpr4w7hUSq1Iua1sg7l3bfJlL0P
         wj+g==
X-Gm-Message-State: AOAM5328nlZsKI6RmKJli1rMEZRUaIluI3CQjpeXKRotnNvrvfBmj2Wh
        ZuGTZ7SdH95MZdoUX7fKkaZb7idORVthCpKEropA2OF/dJow0nQk45l3MlomZmrTraSt7AqAQHf
        LksaIkqbilbQdaPLGEQ1beIQ=
X-Received: by 2002:a05:600c:4ecc:b0:394:3250:d88c with SMTP id g12-20020a05600c4ecc00b003943250d88cmr6688131wmq.105.1651656752836;
        Wed, 04 May 2022 02:32:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO+pbxaczdRjaRn57aZ40kzSJJ6kjffsdlMDg10f1bqbYBn8iIHq0NrVydrrKVdtoougHgAA==
X-Received: by 2002:a05:600c:4ecc:b0:394:3250:d88c with SMTP id g12-20020a05600c4ecc00b003943250d88cmr6688115wmq.105.1651656752625;
        Wed, 04 May 2022 02:32:32 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b003942a244f39sm3382841wms.18.2022.05.04.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:32:31 -0700 (PDT)
Date:   Wed, 4 May 2022 10:32:30 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     frederic@kernel.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220504093230.xmksdyagcpgs7sjt@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <YmrYfSSepamn5fVc@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmrYfSSepamn5fVc@fuller.cnet>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-28 15:10 -0300, Marcelo Tosatti wrote:
> So you are syncing the vmstats on every system call return:

Hi Marcelo,

Sorry about the delay!

No - indeed, that would be too expensive. If I understand correctly,
Peter Zijlstra's feedback was in response to a previous suggestion made:

	"Could we *always* fold the vmstat counters when entering
	 idle mode? ..."

I think an exception should be made for the adaptive-tick mode/or a
nohz_full CPU case when the scheduling-clock tick is stopped. Also, I feel
correctness is key, as previously indicated since a significant divergence
can impact memory reclaim code.

> Have you measured performance of any system call heavy application
> with this change?

Unfortunately not. That being said, the aforementioned test and work will
only take place under a nohz_full CPU and if the tick is stopped.
So this should be somewhat limited, no?

> Then the comment on why its so slow:
> 
> "This loop is quite heavy. Maybe reducing the data necessary to be read
> to a couple of cachelines would improve it considerably."
> 
> The comment:
> 
> "Is there anything that prevents a nohz full CPU from running an
> application with short and frequent idling?"
> 
> Is confusing and can be ignored.

Understood.



Kind regards,

-- 
Aaron Tomlin

