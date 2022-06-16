Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1846E54ED61
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiFPWfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378518AbiFPWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:35:15 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACE6210E;
        Thu, 16 Jun 2022 15:35:11 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 67CC8801DA3;
        Thu, 16 Jun 2022 22:35:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CE1CE801D9A;
        Thu, 16 Jun 2022 22:35:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655418908; a=rsa-sha256;
        cv=none;
        b=FtzwEnKqs5aM6EyTKVd89leR3AA+ANLRdP2N04mlZFnFmUbsbymSL8xEhaMXHSL7yC8pNz
        CnpsmKLJQp9BOHfiiiSmkvAVxRSHKrgWgqe1QdJ9aSZoNM5bOM9wVhQID3mb1/IStu1GBa
        qaGI2iVYWUnxXmGmFK9OL2mBVkxSw47h+ZOBVIk2R2FUl5+oEmDhKZoOd3+4fKJFRAX0iO
        dZeAZGHi8HEBrKofzGz2OHd1P2WnUgorSxlfRTF6o1uVvLz02Gw3iTWy81m6Kgfl5GX31W
        dWHXRvyt1IdtTkKt7rvj3GzBHSdIUrz/Chkt24rKVKO6s3DHhdK9RXXHucONtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655418908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=FQDo/MRb129ADZX+XkIZfbp3tPlh05DubOmMkb1Pe3Y=;
        b=q89F+FzLyhvA3ax7ebTOXmPU+tbx09HfLoxl67KeVBUWnibEeC/f8xpSmDdGVi6JGzVa3g
        4SlQtY1VZsJcxF6pbKzF/YdicuQv49mZcJXgJfZW6DGYkDagWkXNB9vUJGJ/ydjm1debBn
        FwHsPT4RysYYJ9GGxnsmoIs7oxu0ueM+VEo7Lcn7lXc4W1GMumEDmoLoDiaHHBHJ03fOGr
        j3MMEC2ITMjxUhPJhNTW8/QRNaeIp6BDjYjUm4ZZjljR66tlH9AKbyOtHTkxfF0zarvq40
        P2ob2kbptVOivWtwsf5P9ICYT93M0sp+FxVjhZTW/i5lTuZDehNV7EctqhrQSQ==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-9jkmw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Share: 6d388d5b6917c99f_1655418908268_1620883124
X-MC-Loop-Signature: 1655418908268:4216171093
X-MC-Ingress-Time: 1655418908268
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.94 (trex/6.7.1);
        Thu, 16 Jun 2022 22:35:08 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPH6y33nPz4f;
        Thu, 16 Jun 2022 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655418907;
        bh=FQDo/MRb129ADZX+XkIZfbp3tPlh05DubOmMkb1Pe3Y=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=drMCdu2uIo/NNLTErfkizhZZLstIA+O+Y5JfDGcJDYvDfMTcH1K0ieN0Wewm8plcb
         cZcczrcEum5qndRzVn25IN2H2f2CiDsX2pGxze7Mx81O5by8ggHGbur+jwjVJ6+82e
         gfUErX5aU5ku5WBd6OE/UDbC5TkrF4/jKvR2yw3i1N/ylvQjn+3w+3/nVEgDlYzQBn
         NsIugDSst4LPCwCGLz8O7Qyq8Jo1qeIeS4WjeoZEQQ1mAjzuwoQwFKyEEfygzW8XkX
         rbJ/cHYIfe7FoejX1cHJUoC1DgGAqNKSpVCHoaro6B04bA8JnMYo6i1TlMFj9k0fOi
         CByL14JY01lNw==
Date:   Thu, 16 Jun 2022 15:20:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220616222051.wzf4iokvhxnro56v@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
 <20220616214740.7pyjagx3gosni7mw@offworld>
 <20220616221041.GA1529592@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220616221041.GA1529592@alison-desk>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Alison Schofield wrote:
>> I wonder if the latter may be the better option considering that always
>> scanning the entire memdev would cause unnecessary media scan wait times,
>> specially for large capacities.
>
>This is not a Media Scan. This is only reading the existing Poison List.

Right, but I was thinking we'd want a input similar interface passing the
desidered range.

Thanks,
Davidlohr
