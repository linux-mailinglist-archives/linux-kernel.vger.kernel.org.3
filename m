Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AB58CCA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiHHRYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiHHRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:24:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A7915A2B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:24:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so12149063edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=zOlEOnEIXS+Xo9q1aFafHGJZSAvEcux1UlPcAjCpTi0=;
        b=j/sn8o9oy8btPw66WXAnSyjPMKVqGbtSo9KQPaD06oywDtt8wD3eIIa9tccoYDBVUV
         BnyqpbBqjSzbzt3gT95wPjFaEAp2ez8801GluOSyZMqrZV+YFgwJkD4VITr7mTTRGt6W
         ItPGDqSe4gtqg/tKvG4T9VeN52hDRK52PZE5ozSXBzcZzdpXj7FBhgjfK2/atsGfeYML
         1rhoOB647YpSl97oYuhfefvQc4Pkggv93zJR4C5qHjdP4xDleo4AXQA6qmDoEJteDkk3
         w21x08GgMnf8yoKb63BdOvtf3DhanKM5oWOIDshWgPttRXdfk9duKWR25pUHv+SFpoAE
         S0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=zOlEOnEIXS+Xo9q1aFafHGJZSAvEcux1UlPcAjCpTi0=;
        b=Hqi1s19X/12qywjhZxgiFmTKiGF5e1S78ONKpBd/IDHH17zkflhKFNv7V6+/kM1Pzf
         L6ScNXH1CUK9R+6o05jIBhapc9j67VUEmWV4LzkmPbbxDVO2+dA6guw4Z1zm+WtLMzJU
         BntNiCkvUsuJCb2LS89HAbsNLLk8QEKO5pJ6nF5/xYtz5MGQ/adQeFLY4rcqccM3CLFv
         hftSRZAixz77kn8BIXpRirbVVQrf1K5gyVKQIujpO21pS79V7u1DEroQp4oNOtqf0PDt
         AFDqIBhLbmXjkXrGbsjPhxXI8UsBhPSfLX4XySKVR0wE45+qD1/0Eivp7yEoNU2yc7bt
         12vw==
X-Gm-Message-State: ACgBeo01gSsC9qPqHp4Unz3OfyVN7hRSsu6e4VgU8mk1ybg5Do8kTNFQ
        O/aTqKc1mhfAWAvRoarDDw==
X-Google-Smtp-Source: AA6agR6NSNsUVu8zETQAFUkY5l2sQKyswYTtjCTnzvIA4TiXQo6sjuI2bOXe/pBN+YRNVMt90g/q6w==
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id j11-20020a05640211cb00b0043cc7a3ff86mr19229473edw.383.1659979474442;
        Mon, 08 Aug 2022 10:24:34 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.19])
        by smtp.gmail.com with ESMTPSA id v26-20020a056402185a00b0043d742104efsm4819887edy.19.2022.08.08.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:24:33 -0700 (PDT)
Date:   Mon, 8 Aug 2022 20:24:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     knscarlet@gnuweeb.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org
Subject: Re: [PATCH 0/1] x86: change mov 0, %reg to xor %reg, %reg
Message-ID: <YvFGz3iIr5IJL+2V@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>

Patch seems to be OK.

Minus interwebs points for using AT&T syntax.

Changing objtool to detect overlong "mov r32, imm32" automatically
would be cool.
