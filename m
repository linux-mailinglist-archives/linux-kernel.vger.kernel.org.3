Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7031A5B09FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIGQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:22:11 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C236A8CCA;
        Wed,  7 Sep 2022 09:22:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id ED51E24184;
        Wed,  7 Sep 2022 16:22:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AF4DA24133;
        Wed,  7 Sep 2022 16:22:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662567728; a=rsa-sha256;
        cv=none;
        b=Ru1TKPq+I/Q3zRgPOewdrZSK3VC4EnuUWWdADHPWd8WTM26avt0zpb6kw6xqcG4ajiqNJA
        aNgAIThI9ySL6KYh30XexK5uG1zXCYpo6J2RSnDpJ8LsCtztnCSqpX3ykm4QEMOkYL4C8o
        qFXu5e8/5HHsSlYbKJuYLJRj4XdCbDodu44/n4sWraiEwBuOJjijesRIBgxNtMZmk1LPvY
        xF6NlnkBkNMKqSzsUPy4Pxt+4hSayi0iehHwbv4wsKdqUwBCHwACGXLjrIhTHv8s2karGv
        lfHBnDbncccHWEdkbFXPOhvhmMVcRUMC8nHTHZ4Vvr0E9yVy2BsJM5/jMBEacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662567728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Q5I72zuM+lmKwUs/n+14smqnwrEutfmQnYvhJjxKvHQ=;
        b=dMfFuhz9gSDutrNbqKt0ZS/ijg6LWhKRcFoksy6kFU4q57WM2FEqqDkH/2owRZLKFTWLT9
        jJMlHjN35V8XWDrdME6ewOyaXRFcO3FCsPVn/ZvcsNGl5354fTNuz77eH1zjauwGV3DOKi
        2a9lTfT8gYlNk2z2/m/tUa6CAIib0qIqGZ7GlRXbeyr5j6kqIDZ1Ry7tpMOVxOwRwbFklb
        xpG98s0hQO07TmWrBaUsUNuJ0aqZDBb8bRHD4OcXCZY8lwrIDJo7IgQwkMAfzj9/oUHZSQ
        mvQmRcq3llmwlfEco7gp5qX/+8Nonn9aZ4SppPL7koNeUT+HI9Woj4IbhsRM7Q==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-lvkj2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Slimy: 32efb8e01087203f_1662567728265_1947120413
X-MC-Loop-Signature: 1662567728265:2794685740
X-MC-Ingress-Time: 1662567728265
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.108.161.89 (trex/6.7.1);
        Wed, 07 Sep 2022 16:22:08 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4MN6wG3Bx4z6r;
        Wed,  7 Sep 2022 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662567727;
        bh=Q5I72zuM+lmKwUs/n+14smqnwrEutfmQnYvhJjxKvHQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hRrGO9ZE9txtfSu3RNhxninK/xIYDubR17SyPxJgngHVHIVorc2fFStCKvk4IQsTq
         zUEsgWWJCOGMsFNdXgbMOc7roerkDQEKUvBrwrtZ7r7yu7NXo2IrDPxEBz9UkKezJm
         gElGdMh8tgjhL1sbFSFC3fbKbggAG/jK+/uqg+WHFFTRP2l2zmnyHAEUm+7AT3qKag
         H5qLTmEQqLjThgUPV1KoX/naxZioTYwd8FwZKPinDHNKSxCzO4cGdPk5sbAS+nQ3S+
         SPbdPP3qO3pYb+GKpCTJ24Xv+kvSqPVQ86LTjM1T5cK2F0Js0KAsoWCf/NSOelvNPj
         5XAvxgcZT4i8Q==
Date:   Wed, 7 Sep 2022 09:21:58 -0700
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
Subject: Re: [PATCH 3/15] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <20220907162158.56jyjphzzzjgptxu@offworld>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-4-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-4-rrichter@amd.com>
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

>CXL ports are added in a couple of code paths using
>devm_cxl_add_port(). Debug messages are individually generated, but
>are incomplete and inconsistent. Change this by moving its generation
>to devm_cxl_add_port(). This unifies the messages and reduces code
>duplication. Also, generate messages on failure.
>
>Signed-off-by: Robert Richter <rrichter@amd.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
