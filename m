Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C005879F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiHBJjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiHBJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:39:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194130F55;
        Tue,  2 Aug 2022 02:39:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w3so1223082edc.2;
        Tue, 02 Aug 2022 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFQwqqqznTGEXjJGP0GCqKukfQLdTRB/jDpu9UVZUWs=;
        b=JRAJRY44ZuzRpshknUC7cIWE8hqPhZLVESaoKq6M+kYFcJ28mAN5ySLU8hUfVs++E7
         MEdCyR4eKoXAsg3uNwnKRWw97LrAWAfPxc74r5w/1AfUY6enrn31vlujsfyM+OLolT6e
         0silr0d2hlVQupQz/Jz2biFW4kKEA4BUsIMQskN96mstkLEnrV8bvdvFmBRJzMvBDwWF
         DlXxsZzPPSIhtsb2qEIwBAPdC54rjUIeVVzZTHX0P+pndNeDqDB3oJLGDvMQvi2RIFKm
         zLUUViMY+Q0TVoVjmLlScYOWXV+rC8N+AEzuiljhgaLxR0QeT4ldO68CXJCkKery4HJ0
         uwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cFQwqqqznTGEXjJGP0GCqKukfQLdTRB/jDpu9UVZUWs=;
        b=dwN9v/cQNbFYWgyfb3mvkgrtfY8CShm6tGYgErKzFF/dcqrfXXxz0jImInKmI+r3+T
         kUpnVc87HPdo0oKfsGtIWz/nXyqn4ZtNxVTvOi0Pnidv5jSTqLPVu/9y9jNvorWBABNQ
         xDeBqA8yEG0AQES5r2u3Cwpi9uTWEjOuEUmjPnHdE0oaWfv6fA//h55K8fDfbncno4UK
         wof4QmR6ZWYvFIWMd9pDDjEb5vJYViBT0AUgQKWw2mtZTaQkex3G0iuBimFZ0bh0FFBp
         ylRFI2IOM5CaDjk8/k98rinqtPxK2/iNOX3UWzi5NsMF+q17oa0f8wvTajeVaWq1UbOr
         n6sg==
X-Gm-Message-State: ACgBeo1YAYFhpqSin2zO/W5LOWJdot+3SEv14O9tg5oFtm/7ZhcYpYQw
        1tbE84jjfSuhwuWe8QMp6qI=
X-Google-Smtp-Source: AA6agR4p5uaDWMAjWS724wffcK/PfHf6PF/eO8Rv9jiiBPYTbI5uudmhUbMNrPUqbDeI/D05fl89OA==
X-Received: by 2002:a05:6402:40c9:b0:43d:cc0d:e9de with SMTP id z9-20020a05640240c900b0043dcc0de9demr6087800edb.319.1659433170946;
        Tue, 02 Aug 2022 02:39:30 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b0071cef8bafc3sm6028201ejg.1.2022.08.02.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:39:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 11:39:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, eranian@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 00/10] x86/resctrl: Support for AMD QoS new features
 and bug fix
Message-ID: <Yujw0FOMj3tS0f3k@gmail.com>
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
 <13d16a59-0b13-8484-380c-21deb864f0f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d16a59-0b13-8484-380c-21deb864f0f2@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On 8/2/22 03:55, Babu Moger wrote:
> > v2:
> >   a. Rebased the patches to latest stable tree (v5.18.15). Resolved some conflicts.
> >   b. Added the patch to fix CBM issue on AMD. This was originally discussed
> >      https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
> > 
> 
> Shouldn't this series be rebased on tip tree? I think it's odd to base 
> new feature series on stable tree, since patches on the latter are mostly 
> bugfixes backported from mainline.

Normally that's true, but AFAICS the patchset applies cleanly to latest 
-tip as well, so 'stable == tip' in this regard.

Series looks good to me (without having tested it):

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
