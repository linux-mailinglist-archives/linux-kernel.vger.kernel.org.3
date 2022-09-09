Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7A5B2AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiIIAQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIIAQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:16:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F05BB932
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:16:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t3so295473ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=k2t/R6AQ46zsQvTCJV7JauqbK0LWOyK9K73x38TYMG4=;
        b=WUm+62JK3r9SWkPMDYUEUj251tZInPIVDDvOaQeKMeKJX97/AWXrgKEyZIbGwetAdA
         4XZpWsL9K06HU79dYcfaR49oAgO+R/vjJ0ut7vbsPB0v4GroBXKz/IMSzgLmE8d4SVMd
         ht7zC/Jt21lShDafGkNqV2U00w8EBguPthQWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=k2t/R6AQ46zsQvTCJV7JauqbK0LWOyK9K73x38TYMG4=;
        b=laCFKItN8WdU/5bhhVh8pg979MQT4g3zyZzNWJ/wuPsdPRje0foXMmJLcTrvIH+vso
         ALxnmvkJiDowk/87/WGo71qwMoXNAqr8TKPTF5H9ulkUfwAXwlVynMZSZUnIb5Wo1tos
         +3eEUBQg6ZuTO745L6tl2PyFm0+2IoUY8le6Nvy+x4Ih1WeqcpWrnfK23Qac3tHfCLEP
         FXk9zGQDSKsZTIIwoaYOb4mqbdfVQputvryy8qbuNkk+UjGtCRxIgAQVmlr/1nVcgE5+
         R3z+cQvYjA1KZbXW0N8qg4qvXdqRNuzn/Sv3tFybiRKojd5vYeEKK60iB/UsKmEGNr8g
         Z0Xg==
X-Gm-Message-State: ACgBeo1H2mGKyOjrFwmji+hW4OqLjuKsJjL9XbrTC2Lw4RG3K8sxMjJX
        5qKvte5lSYxFDL3K+PpbbW1Xqw==
X-Google-Smtp-Source: AA6agR7TBjxty48rT/ZoXgbEj8jNFRTwfrCyK1GcWP6laM7bsyQxxS7+6Oht/HAbiyKMbE9DaUiMPw==
X-Received: by 2002:a17:90a:ac01:b0:1fb:8956:7942 with SMTP id o1-20020a17090aac0100b001fb89567942mr6641952pjq.107.1662682580137;
        Thu, 08 Sep 2022 17:16:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:da1a:c731:7561:7e5b])
        by smtp.gmail.com with ESMTPSA id b27-20020aa7951b000000b0053abb15b3d9sm226997pfp.19.2022.09.08.17.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 17:16:19 -0700 (PDT)
Date:   Thu, 8 Sep 2022 17:16:17 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxqF0bWoJPK4KFHb@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
 <YxDWlgulBijTzj3y@kroah.com>
 <YxEy8mTO1nZ1sxHV@google.com>
 <YxGYepQlLZTE84HB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxGYepQlLZTE84HB@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:45:30AM +0200, Greg Kroah-Hartman wrote:
> before/after in the changelog comments are very good, thanks.  And yes,
> tests are also good, I'd gladly take that too if you do a v2 of this
> patch.
> 
> And make it independant of the tracefs change please, these would go
> through two different trees as they have different maintainers.

I think I've covered all that in v2. The patch contents haven't changed
-- just the metadata, and a link to a draft LTP test. As noted in v2, I
plan to submit a PR for that once the kernel changes are in.

https://lore.kernel.org/lkml/20220908171319.v2.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid/

Brian
