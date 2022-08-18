Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33E598680
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiHROyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343768AbiHROye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:54:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E158504
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:54:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a15so1279044qko.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=hcxf4nrKLmomhmzX0ig09AZrpv2UbK3GaLkKfXfMQZc=;
        b=HhA5fDrmzi9qNfm3ZS/2pEZ/XaNpIC2qHSvH9QReheXboKuaEp3on5w0CLFSDc+gQw
         zBwcH5WrTQZ7P/20zyrDf82+SfyXPQlyiDQi3NyAzLh5G3CimoV+A34dFFYnpCpZfHaE
         WiU18Q11o6+yxvQVMUXY5rd8dR2tC6+E1GppMu6HjAfX81DhcVZrZ1LdThZciRfMl/q5
         FY2maZK0wZWAPwcy/R88d2cGry4UOw0kU3UiOYC/2ts8AwTFuEzSBRftVdXnHJQU5ZCP
         XYyZOlbspr5dXq9QxpCtBhk6rpihbZ9Z+pJqm5S6QGjN8JsrqqEe9BDxJTUE2MmOxd+t
         orWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=hcxf4nrKLmomhmzX0ig09AZrpv2UbK3GaLkKfXfMQZc=;
        b=exT+QRPXIEv9aqO+QG8X3ZvEpZJ3PL7z6wWJl/OWaarlFcrVj8rbALrcU7WSKjOv2q
         bGkkDYEJwjTM5WSTlUUzovIPAlsgPF7MWSa34O9yYpeveENvN48pX6LGhAiRQK6yp5ql
         SCxYCOLe85NCJJ62KQ5TDCscAxiHoOdwl0PUe0FIIBlyKfcC5aBlk3Fk9LdHuVcFsAld
         CE8Ej8So2XiK+EaCNw+fm/Dc5Tcg/lcgxOCIxddq1X8R7C+hy0K1CdGZ8b0NReJnNHal
         8LmHLjTFRPRH3pt7DjCc5PQPMw8bHW7jvX+ffll44p+xNvzbVw0VkQ4KpAxQamR7ew8p
         ZO6A==
X-Gm-Message-State: ACgBeo32jUqQb9I+FtP71BMOmHLsT5dI7YvbV3n4zD4/sbdNEGfa8AVe
        lesCjJ853N4EXZEVCGlelZ0pOUU4t2E=
X-Google-Smtp-Source: AA6agR7qtDGktx535tr9lRahEn5NIgi8DAsYkmzX3y1QbfXPLIomS1816kpH9mlsSmjbQ98upfQUUg==
X-Received: by 2002:a05:620a:b15:b0:6bb:c6d8:5058 with SMTP id t21-20020a05620a0b1500b006bbc6d85058mr1037906qkg.698.1660834472227;
        Thu, 18 Aug 2022 07:54:32 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a2a5600b006b945519488sm1730546qkp.88.2022.08.18.07.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:54:31 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:54:29 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: checkpatch.pl bug for EXPORT_SYMBOL when struct initialization
 follows define
Message-ID: <Yv5Spab6mC0U5w/v@spruce>
References: <Yrt8XgMe+mMIlHxM@spruce>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrt8XgMe+mMIlHxM@spruce>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 06:10:41PM -0400, Joe Simmons-Talbott wrote:
> I believe I've found a bug in checkpatch.pl where an EXPORT_SYMBOL for
> an initialized struct following a simple #define without an intervening
> blank line falsely reports that EXPORT_SYMBOL doesn't follow the symbol
> definition.  Here's an example:
> 
> 	#define SOMETHING_ELSE 1
> 	struct blah foo = {
> 		.a = 1
> 	};
> 	EXPORT_SYMBOL(foo);
> 
> You can see from the debug print that the full statement has not been
> identified.
> 
> 	FOO A<+EXPORT_SYMBOL(foo);> stat<+      .a = 1
> 	 };> name<foo>
> 
> Unfortunately my perl skills were not sufficient to find a fix.

I created the following BZ https://bugzilla.kernel.org/show_bug.cgi?id=216374

Thanks,
Joe
