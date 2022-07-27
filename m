Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C399F5833AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiG0TeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0TeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:34:11 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ABD3B95F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:34:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q14so14303935iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=N/0o0dD/x+CwkyBbvzJIC2K+biUXwEeiHAmV87rToR0=;
        b=cjMfC/aLwYRalhLFQROzJkq6tDQeAQ9DdKKW4zcLv0lhdpLGh6j53ISEFM+S9DCN4c
         leJt+6SW8WtCmfgIQ/fbZ/Y4zerHtwk4Up3th228U431m/guJkLe57il80nM7Vagr7cy
         ihAovbsahVrnUy+0WN3O15aYnGP4rHuaZ4qeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=N/0o0dD/x+CwkyBbvzJIC2K+biUXwEeiHAmV87rToR0=;
        b=yR+bw2PwjMPmdN7BV2Ax7WfkMCZ9EcHMDi9LSoSxbjoDOstaOFdsNu76mkkvRg/zlI
         fKPv0PqlEbTD38lA7HnIkdvGutnoCb1x3B25E9GT6zQ+TiWRbmbBsD9/Topn/7htX6CF
         4zVVA7yM3s0ZIIZx8xRve73V3pKzEXGhdw2nPvOK5sdzDBNMZoKKQVMwFsj6OhNx5gO2
         UITVPOjVnwBb85W+3e8All9ZUJS8WpbhCapWbdlaRZe9zapMTLonNdM7DbzX0Iaat98Z
         XOHvECbX9CMzbnDG7Aq1ZdfB4hOqjVcnoafiJvNvveceFrOtSMRYL6Y7RX1AoMYI73Ue
         aeAA==
X-Gm-Message-State: AJIora+rCYyy/w8AmW6943kTPJnk0xsYCYwud39srIkXpIwgcaiJ0K/p
        0wZCdO/MwfHw9AlLOnkkk0yVQA==
X-Google-Smtp-Source: AGRyM1stnNLMExpZBm4LjSwakLqZM+Npc6FXE7Vl2e/xFGesNUPhIM8s1BjEnAt2bNt+9i92RzUaeQ==
X-Received: by 2002:a6b:c501:0:b0:67b:a949:5edc with SMTP id v1-20020a6bc501000000b0067ba9495edcmr8327777iof.198.1658950450351;
        Wed, 27 Jul 2022 12:34:10 -0700 (PDT)
Received: from chromium.org ([2601:285:8300:c23:7d3c:f486:4e4c:9feb])
        by smtp.gmail.com with ESMTPSA id d39-20020a0285aa000000b0033f07b375b8sm8343087jai.52.2022.07.27.12.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 12:34:09 -0700 (PDT)
Date:   Wed, 27 Jul 2022 13:34:07 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>
Subject: Re: [PATCH] firmware: google: Implement vboot workbuf in sysfs
Message-ID: <YuGTL79tPPoalk/j@chromium.org>
References: <20220726235115.1184532-1-jrosenth@chromium.org>
 <CAODwPW-9UPokepL_VVGuCLaWTDT7hmN9R9Z2yXABrP4g3_N4uQ@mail.gmail.com>
 <CAE-0n51RsN3P5hT+kApw-kPqjm_K7=7bvySWLNdQuQPnrQYZRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51RsN3P5hT+kApw-kPqjm_K7=7bvySWLNdQuQPnrQYZRw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback.  I will re-work this to be a more generic cbmem
sysfs interface.

Jack
