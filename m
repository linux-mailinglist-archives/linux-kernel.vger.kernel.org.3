Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67DB534BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiEZIYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:24:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F0C1EF1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:24:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f2so1251518wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=19gn52/CILDHcyYZhtfJSaIpE45GA5X4DLumc17J+6E=;
        b=kxVNDsdjeN8srlZR4+tE9FFTL4P6Tdt70Kom5we3WpF9MTiFXfcVdeCfTU1BLUQKM0
         Q+2DK0HhNgjnAmJA/gQ2MCwVGYuYVXR0E7KyAoZqmHLBbg1gXDK6NcxeaRWcHfxRRbjg
         NdE1wQlEk3uyXGL7zxHn2mDGBc28n1wH6k5GnVwiPLOaC6Ai6ij1Qn33hgo9qg9XeZad
         lkSlmYeV0HztGgJJ0rY05XfRh4Lie/CF+U+JVCJlIhpQE9TCtq7B8H3kCMo6EjD9xN8x
         EMXTSx3lge9xsEvAnjzopYj8FtZ1BbVMxIuncAzJdfzbLjpUJpWbj/zSjKelKyOrvbwq
         jFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19gn52/CILDHcyYZhtfJSaIpE45GA5X4DLumc17J+6E=;
        b=CAM3jgWiBw1uIYcKy63fd6YNMZ7eNe3cyA8lqc0b6t69mEwOvZap0Mvzldhcxoxt1P
         wIH1rHNaLJkYmiyQ/C8y1GPzYWcaMNA0KQpFpHW7DM/2qNGXG+SFJbOK8QZDI7J+jHmO
         SqUXr9VBfSSkgIbI+aSrIj1FHQNrfcNejsuwZtXI91yBh/rPsvPYPbXLRywXFfzhzPfU
         Y6lZHak35kKUnrTcGPSSsuX7+19lrTitig9tD2TT8P9QvO7cro09YhC6TWvFcAizC5MJ
         bx9CGo2dzU2bMyGTUFrRTK099IYIIjW7ouuI8vfXNiIh8Rb3ai57cIPuckHVywM8GvjR
         t83w==
X-Gm-Message-State: AOAM5335iZcTqK3Q9+MpdacCG0FrExG2Vu+Mnc4198AAilhmPGEciNLW
        Y3C6HaOBmcUl58TOATmHxoY/cg==
X-Google-Smtp-Source: ABdhPJwKuRRw7Ncg19gO8PWVEmbNAVU/0uaj59xksn4OObwl0OodafnRVdem0pKXoyJlW+i/eYT9kA==
X-Received: by 2002:a5d:5041:0:b0:20e:74e3:1d3b with SMTP id h1-20020a5d5041000000b0020e74e31d3bmr26046786wrt.323.1653553472461;
        Thu, 26 May 2022 01:24:32 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003942a244f2fsm4277906wmq.8.2022.05.26.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:24:32 -0700 (PDT)
Date:   Thu, 26 May 2022 09:24:28 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <Yo85PLANCnCcMgvD@google.com>
References: <20220523160536.2889162-1-vdonnefort@google.com>
 <20220525165248.GI2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525165248.GI2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 06:52:48PM +0200, Peter Zijlstra wrote:
> On Mon, May 23, 2022 at 05:05:36PM +0100, Vincent Donnefort wrote:
> > The DYING/STARTING callbacks are not expected to fail. However, as reported
> > by Derek, drivers such as tboot are still free to return errors within
> > those sections. In that case, there's nothing the hotplug machinery can do,
> > so let's just proceed and log the failures.
> > 
> 
> I'm confused. Why isn't this a driver bug?

It is a entirely a driver bug which has been reported already. but 453e41085183
(cpu/hotplug: Add cpuhp_invoke_callback_range()) changed the behaviour so I
thought it would be worth to revert to the original one which is to not break
the entire up/down for a single driver error.
