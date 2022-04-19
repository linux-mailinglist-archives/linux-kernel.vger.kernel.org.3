Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4B507585
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349826AbiDSQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiDSQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:46:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9939692;
        Tue, 19 Apr 2022 09:43:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x17so30408634lfa.10;
        Tue, 19 Apr 2022 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gyw0DllU2NEgcTB/Sa92qGNKU8xdBjvfAuK5cohiajI=;
        b=asRrscuJnEsdZ1tzYA0fN9xCDH2APZtdudLZmkQnLh6p0uiaAxipNglQMl57a4UMxy
         78eqnW78ESl336vWjH8XLn8Zd43FNXLdVkToS0MiB6cvvCy2PmJYxYWrvV7lMB4CNhXR
         6Y4WnxmZ0LRShtGTEkrW7DoErjKohz+R86lgBhFL1gi0q1bO0a/MR3mNtUq6EtaTE/i0
         6ckG3UJ/dn5qBWqHdT98XxrjALJfahY+7izZrCdcWLEW9h2azZq5+m5LqeZqFzxfzu1/
         F50tp++qazDDdaa4JJjgBBXRVfCClJcgaU6IZpyHKa6Maw20JmgOSW9AwydqsQ8I6qCz
         gSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gyw0DllU2NEgcTB/Sa92qGNKU8xdBjvfAuK5cohiajI=;
        b=F7pbVJLUWUKzEyXLfODi0AwsRXNm1gtoyCrQIwZqWzsgAY/m/YuF4LXNr+Xij8H0VU
         1S4AEkDdrzk4paUxBQNXoP+ZHJVvQjZvj5GLaIOAncChDLP2iZRWbO5rc2faEjlpndJF
         NQmjL+Frg3Fb5cu26x9AaN7E1q4reSluxyqEQgdaIKTX/kxguB5xeuh6iAeaC51c8g4I
         pfVvsGuUwkh4jvufHRMKghuM9JNFNxxThe0g6jFCNvbbdHIIet2688FkBjLrJijg8uD5
         J8qcpZfObT/497oHpRXPFi+AkCVOw50yADiSx0m82ioJ1h3sx7SVxNlkJ707MH9LLARk
         9hyA==
X-Gm-Message-State: AOAM533VByyqEwIdg+34BYm83sqw2puBSdBkiDnRp5X+c0xUIVcE2LfH
        sL5dXX4LQ9NzpBZBWVUhY1o=
X-Google-Smtp-Source: ABdhPJw79nRXKU8UnnOwpeWQ6iU3EAQKrdBBD+fWBtL4nWEsSBKj2o68Cnkizg4e+tkZK6f6yIYWwA==
X-Received: by 2002:ac2:4c4b:0:b0:471:a8e2:198d with SMTP id o11-20020ac24c4b000000b00471a8e2198dmr2671909lfk.121.1650386617950;
        Tue, 19 Apr 2022 09:43:37 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id s22-20020a197716000000b0046bc65188d6sm1562325lfc.80.2022.04.19.09.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:43:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 19 Apr 2022 18:43:35 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v4] rcu/nocb: Add an option to offload all CPUs on boot
Message-ID: <Yl7mt2XkHo7obhpz@pc638.lan>
References: <20220418175403.2553842-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418175403.2553842-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 05:54:03PM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
> 
> On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> which ends up not offloading any CPU. This patch removes a dependency
> from the bootloader having to know about RCU and about how to provide
> the mask.
> 
> With the new option enabled, all CPUs will be offloaded on boot unless
> rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.
> 
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> ---
> v4: mostly style related fixes.
> v3 is back to v1 but with a config option defaulting to 'n'.
> v2 was forcing the option to override no_cbs=
>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
