Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733D05B0A14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIGQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:29:17 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF671760FC;
        Wed,  7 Sep 2022 09:29:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5CC19804255;
        Wed,  7 Sep 2022 16:29:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a245 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7880A804012;
        Wed,  7 Sep 2022 16:29:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662568153; a=rsa-sha256;
        cv=none;
        b=dRUN5cEP9CLIglLhrroHgAtdBN/uYW9rdl5GWMMRTgSYkjZRxh2rtqOeEhlJpiX1K9Zilv
        IYvGte4rg4zEOkSU6OAHwi+Fil1rxUYFrki/z9vmXnspaqySNy1LtY345QiWojDwgLgPQX
        YbE38LuTs4LbqxKsj+xm+JSAj0e17mAcE3Lu/JKVqGHUFpmCrlZbXpslKs/TpqiQB9E8N+
        GV5FWGBEMOelf7sQxSyg6tdZ9x9LMTVhb2u+CMtIKW+uej1Jd89+DlRYz/BtMJ4HdVFq1m
        +Q3MivU3yKK2TP6tIICdnxlp2c76RVkHTK5R8cXNuyUItFWuMpQAGIalHqjAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662568153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XtVZRkL1gfzjQCH9ylYUzGOb/1yvXJoQCYJw5D5BDhM=;
        b=1iqGTQZ9K0+oL6KxEWUkclPwZvyK2/wrAC2OMpXxVIMuwkEGwBlzDQf42kkOK8Ba7D02Ut
        7RaR1mxgN7YURI1+W+pjzN98U03MQMuPKSS68LjgZ3MFtvsAWyQ/viJ2YTBVdzUm0wlYkC
        oiY7bUg4V7U8cBch5jdykNxG/lQKcNGH72IIpg9mdj22u23dyZwr/bAIzyuVb67RX6JVI/
        CCj6L/JlcrvW9Gq2GynuhNrFqwzlHk2S6LvyiIY+R3iqtDGIz1Cq2bcMjE/RMdn0VnNMhT
        kcyjvneT+kYSkYTnv83UUScUGXWoy43X0RWz78bGdwhyF9eUWHlQgvI65O8LLQ==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-gn4mw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Obese: 29ac9670587cf49c_1662568153816_2799369466
X-MC-Loop-Signature: 1662568153816:2515784960
X-MC-Ingress-Time: 1662568153816
Received: from pdx1-sub0-mail-a245 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.108.161.89 (trex/6.7.1);
        Wed, 07 Sep 2022 16:29:13 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245 (Postfix) with ESMTPSA id 4MN74S54Gtz3d;
        Wed,  7 Sep 2022 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662568153;
        bh=XtVZRkL1gfzjQCH9ylYUzGOb/1yvXJoQCYJw5D5BDhM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NLEgk7R+9gP+wCNXkZ1L/pdSppcFOpk4i+kznPAL8K9FCd611z2eqJDwV41WOt+pN
         N8VtVyGLWr59ngAi4NOIYQjf4VejyUovf7sH7/9YKl3511CXUApXuBLZH6DdTkBN2I
         VcDvr26KquOysi4RJ1UbpqMoprEd3htGqWJYEjwK17TgYEsMQ4nG1BvMgsLJlOs/mM
         4KpJrxd/DngofuZeHxs6+4DMDwVBItzmmZcT46p6xjBQHYaC8P5HbW3Acvc1jkQ//K
         eTapXWIc2a61D7bn9IcgEwU+UV6Zbnk3c7qsgmK/3xK+QkshGWuKWVXz1iZu39b6HF
         RiA24K9xKmD9g==
Date:   Wed, 7 Sep 2022 09:29:09 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/15] cxl: Unify debug messages when calling
 devm_cxl_add_dport()
Message-ID: <20220907162909.sum6u2kb3rma3oxb@offworld>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-5-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-5-rrichter@amd.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022, Robert Richter wrote:

>CXL dports are added in a couple of code paths using
>devm_cxl_add_dport(). Debug messages are individually generated, but
>are incomplete and inconsistent. Change this by moving its generation
>to devm_cxl_add_dport(). This unifies the messages and reduces code
>duplication. Also, generate messages on failure.
>
>Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
