Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCFD598A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiHRRlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiHRRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:41:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E744726AD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:41:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gk3so4544410ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0jCSeYuVem/2OAtn8dTIxb5LJZ9dGd+2D6DlFBKaPvM=;
        b=VibKS/V+5mUSpao1nLTrlaWPzLxq3Mk23Nf/zGYGyNOUUDGMAPDPwNjBDUOYXx45dS
         68rSYHEPOqGL5VXWod4uWFm9eAMAoMLwkQBLkV1tD84lhjNctLRULE+L5oXnTZHOe25+
         ZwnwLkDL/C2qvAlhTXZWnT/X907+UP7yCr0PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0jCSeYuVem/2OAtn8dTIxb5LJZ9dGd+2D6DlFBKaPvM=;
        b=p7MCC61xn621SJZF2vj871DzyNYRq5mYidRP6orP63eOSx4PWRpyfAY/Le+dhq7WKl
         LkQuVIAumhYhT/mmYlzBPkln8FhONxjNHadsu+mjlHGIGVh8/3rcZDAQuhsozXMuzzpR
         ipflF1ieUzM9Gf2JCsvaJZ+dRhVipy34nxZTQBueW6BrmZEcbZX19emdr+aPncyDFSnj
         M1w9m2z9KrXnjRn4IBe7rYgCwDQaLjr2vyVUcz7DTHD7kGAclgT0kI+8P9Gk7NTDIqRL
         oU2NMlf+0zkH5SUoQ7mBDuZ/0EODijEu7C1SUtHg2AiDirssYYUBJkAMTcRYBfSIfXrb
         VFrg==
X-Gm-Message-State: ACgBeo3hLqzc0KSgEJhWd1B8KrcudDKxXiuHFSRf5c0g5lPpBGeKaoMj
        3T3Qj/v5eZe5LK1qvFg7Prn47ioDnx0No/hL
X-Google-Smtp-Source: AA6agR4Fmud58iQjHYeU3KL9UTwLO9jbLh3yKmdklx7qaSpc2xWAwiUqI75ax0QtHeISdev4Od6Dgg==
X-Received: by 2002:a17:907:2816:b0:731:5103:baf2 with SMTP id eb22-20020a170907281600b007315103baf2mr2450653ejc.429.1660844498546;
        Thu, 18 Aug 2022 10:41:38 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7ce19000000b0043cfc872e7dsm1487294edv.10.2022.08.18.10.41.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 10:41:38 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n4so2522297wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:41:38 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr2244715wrn.193.1660844497723; Thu, 18
 Aug 2022 10:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220817162703.728679-1-bigeasy@linutronix.de>
In-Reply-To: <20220817162703.728679-1-bigeasy@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Aug 2022 10:41:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wia=RhHOsbBpMT9qP2Vkig=P0=kAWnx6OoJuZjwck7kBw@mail.gmail.com>
Message-ID: <CAHk-=wia=RhHOsbBpMT9qP2Vkig=P0=kAWnx6OoJuZjwck7kBw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Replace PREEMPT_RT ifdefs with preempt_[dis|en]able_nested().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 9:27 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> This series introduces the macro and converts already existing users to
> that macro. The u64_stat interface was simplified to make the change
> simpler and code easier to follow.

Thanks. Apart from 1/9 where I had just that "this visually looks odd
and threw me" comment, this all looks like good nice cleanups to me.

             Linus
