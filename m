Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979DC594C79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbiHPBJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiHPBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:06:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D841A7C39
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:53:41 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x64so6784755iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uc9DV/Vm8k3ggZyBJiM4DPc4itKMLkWtsIueLCMUQls=;
        b=bIzLQ1mCS/G20XnsaN4dTFCvt9i+9+LgfE1kqI80Xn2j8xy9S68G+j7zgUI9n+e9V0
         iF7lz37EqbKz/yHauroPHA4IE9esnp+eSGtXZPje2+P/Nh67Xs6Jt3JA+kJ0paGNnVvF
         d0uwcC2SiIxnEiE2t3Pf+nzvl8Av3XrytT21Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uc9DV/Vm8k3ggZyBJiM4DPc4itKMLkWtsIueLCMUQls=;
        b=RNAURY4D12eXP/3eTzYGtBLBJcvj/5V54hE2WPeZl8E3P9nJq/DUmmN/MYilyW9cep
         ue6/cKZ52nOe7qoNVrJCbjOPTxgJ1LDh8n0XgMXjkVm5od/QHJcUWC9OEyxEZGQE7HlN
         qnh5RUQyDblXcXLuwBQnDP0AIFc5HuQkzrj/ldc7PA5nsUmEuJoe8CYhnEMH7mdIKOu3
         pFvZPla3+lgvM6/AVg3p7GSDi9u/5tHJwR4pB1wgFuKj1k49YXQ7hky4M6mMBtI52Knx
         uMlVvWYHDiRQCcU8FpCNe+SMLRp4J2tIi9MVsx+6u2os33+dDncPVQgzzDohIGhFmBBs
         DSUQ==
X-Gm-Message-State: ACgBeo3WRlTKM4CO8isGjyNLpT2TEtUnPw+FjhAigGWDh2a09YTvzDwR
        A8RgiVgO3qeyvEP+Y3ZtK7gwJw==
X-Google-Smtp-Source: AA6agR7ifnwUc81UjL6LH46tcLGYwLeVFtSQbHh/vtVpAp80K3Z9Mi4n+8FSzJE+HKr4UpM61ae/PQ==
X-Received: by 2002:a05:6638:16d3:b0:346:a4c6:fcc6 with SMTP id g19-20020a05663816d300b00346a4c6fcc6mr612791jat.147.1660596820565;
        Mon, 15 Aug 2022 13:53:40 -0700 (PDT)
Received: from chromium.org ([100.107.108.157])
        by smtp.gmail.com with ESMTPSA id d70-20020a0285cc000000b003415b95c097sm3804296jai.42.2022.08.15.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:53:40 -0700 (PDT)
Date:   Mon, 15 Aug 2022 14:53:07 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v8] firmware: google: Implement cbmem in sysfs driver
Message-ID: <YvqyM3n48Q/0i9XZ@chromium.org>
References: <20220806204857.3276448-1-jrosenth@chromium.org>
 <CAE-0n53gc=1vwZbhGUaF2EyXotMPjqoQixUMJDidcs7vLmNORQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53gc=1vwZbhGUaF2EyXotMPjqoQixUMJDidcs7vLmNORQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the detailed review!

On 2022-08-09 at 20:49 -0500, Stephen Boyd wrote:
> /sys/firmware/coreboot/cbmem?

Fixed in v9.

> > +#include <linux/ctype.h>
> 
> What is used from this header?

Not used, fixed in v9.

> Are all entries supposed to be writeable? Are there entries that are
> read-only?

The idea here was that we could use crossystem to update the cbmem entry
when it makes changes, however, I do see this as an odd usage of the
ABI, and in v9, I removed writing entirely and all entries are now
read-only.

If tools like crossystem need to maintain changes to this buffer, they
should either maintain that copy themselves in /run or something, or
daemonize and keep it in their process' memory.

> > +       return cbmem_entry_setup(entry);
> 
> Is there a reason this isn't inlined here?

cbmem_entry_setup was already a little long, so I just did this for
reading clarity.  If you think it would be clearer just inlined here, I
can change it (let me know).

> Need to set .owner = THIS_MODULE unless you use
> module_coreboot_driver().

Done.

> > +       if (!coreboot_kobj)
> 
> cbmem_kobj?

Done.
