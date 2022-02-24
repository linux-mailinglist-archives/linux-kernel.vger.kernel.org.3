Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7D4C2CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiBXN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiBXN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CC3FB0E86
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645709301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psZr4jDZFA2vXRGitiJpCpve4DYNl/gB1HAhwDvFOEM=;
        b=jFx8yeM/Gs5BifaIN1+LO7TZMpWhX18uQqDj3U8xR2dVpGGP1yWTWYBjRr+SJeiLW629wu
        UVOuHLIq9WwLsiLYR+Rq/YBU7zSCQ0VpPErYyG6kkHmw7UHgQtR31Lp8gDp1S//Ni7VCYg
        47HP5XA0fZNuJA59X/DsoTlQMhf21zQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-DbZy4lSIPF-Z0GrVSVZMXA-1; Thu, 24 Feb 2022 08:28:20 -0500
X-MC-Unique: DbZy4lSIPF-Z0GrVSVZMXA-1
Received: by mail-wr1-f71.google.com with SMTP id c16-20020adfa310000000b001ed9cd8f4c7so766792wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psZr4jDZFA2vXRGitiJpCpve4DYNl/gB1HAhwDvFOEM=;
        b=DpJIOtPUdQ/Vk2pIAZZU2ZNvH1ae10e8oYX5O7B2GWSInFWBy2ekjyu1PbNN6s/e5n
         vmz7zHTAdGgFIt7s7KlpXOHZD7+tkLvmgkYnGpL5KULArXXz5Atux6lvjTon2RgqvRGZ
         cP2D15d/UyNjnLCN583p6J/CiKXDJ5kmhcmbR3dC9m0LRzzr9KbkYReNisvTZjPqYNTL
         3jsCxxju9dLAOsw4XGFGQl/yItzvR3GRVYVHG/sasGnP7NTdwF5oQDqY8pCQBBna93Gr
         J6e17hilk5NH8vXf2TtwE24NXtBcXws7Tlrja6ekwJcj9CwRnWhrB6I4nU8PJW1sK6ko
         eexQ==
X-Gm-Message-State: AOAM533uPyYnNb3zXTLlETkIQoCO9gZ6rkdt3h4ApBHjTyyeilUWjekb
        +voRSt9nr/w674ZqR+7k+tCjwoPGGEAy1gyD3tYqogJ1KKDPMFwQEv3/1ihIa8UVl6KQ4ubwddw
        l4dq7M9GLQFcO5VGYm9WPgGw=
X-Received: by 2002:a5d:6a4e:0:b0:1e4:b619:52b0 with SMTP id t14-20020a5d6a4e000000b001e4b61952b0mr2158393wrw.504.1645709299420;
        Thu, 24 Feb 2022 05:28:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5cFa1a1boJUcrdDPIdjZCohUc+uHn6SwTHV0xA9uehxBSNdr0AG9/cLNR0CXvMFzZI+bhEA==
X-Received: by 2002:a5d:6a4e:0:b0:1e4:b619:52b0 with SMTP id t14-20020a5d6a4e000000b001e4b61952b0mr2158377wrw.504.1645709299163;
        Thu, 24 Feb 2022 05:28:19 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id ba27sm2815015wrb.61.2022.02.24.05.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:28:18 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:28:16 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220224132816.qsfa66ao3xdjdxxx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
 <20220224130014.rmhtx3xlepybuxn2@ava.usersys.com>
 <YheE0joXm53Hxn4J@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YheE0joXm53Hxn4J@fuller.cnet>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-24 10:14 -0300, Marcelo Tosatti wrote:
> If the per-CPU vmstat_update is limited to happen once per second, that
> shouldnt be a significant performance impact?

Perhaps not. Albeit, is the interrupt worth it? Then again it could indeed
be a long time before the idle task is selected and a return to idle code
were we'd check for any remaining differentials with the aforementioned
patch.

Kind regards,

-- 
Aaron Tomlin

