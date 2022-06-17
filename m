Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723B54EE5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379199AbiFQASG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFQASC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:18:02 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A774BB91;
        Thu, 16 Jun 2022 17:18:01 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B2E24122176;
        Fri, 17 Jun 2022 00:18:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 306D51220EC;
        Fri, 17 Jun 2022 00:18:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655425080; a=rsa-sha256;
        cv=none;
        b=IYdBI/5RpK5K4E2/HCuGO2w7sMuiDkTOY3eLWB1YZk0hs5oP5DalvJzWLqXvObPTb8rYCl
        +Nr1NGAfcAFxJLu/wWUxi+vx4fhePmGJXPxiqIOEiqZJ6OWQ7pAmn+9i0mtePlPR+6l1/9
        g2nQs8KaC74cR6G4OqMUhTIEC6twwr5cxU5Dt+EWUYtvGDXTXdfdIWRxBnfnKw+u/ZuILV
        XJeWHRujTp19iB0t535YR2OoKjJ+trYpvcxXYLmzcBK4Sv/1nwURqYeyjoEWeSbAa+X7iv
        JjZibJb3OG2WHbwK+H7gBaGD7fO8EiMTp7MnLdZiI/uJ1ZtPu0YkwjqIeiBIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655425080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+/SlzhiUqodCSKW9AbFuoqssPBdtJH4ycGuoP57nzQU=;
        b=74C+fN6aHCGghFYtqVtgQfYjD1fm5oNPufc4VR12IZpaSwlAjIX5EjhH+BwCbCpczGCwvW
        A5Ax6jc1hIBWYK556iO/66H0lzauR/8vq2qJ3BGp4AxuT9G9FGHPw48DhR9jwrsPFq5icC
        kfwvMBt7GDUO399gCnyc15odb1JSfY/RhY0vaNEC87rQdVDmDLSMWvRm8uAH519o+nThdD
        9tKcBU3RB+wCd4w/G/pVHCGTviemogyKCvNy4aCMLhFsNcziDztgBSjNbIhsINP5vF/FvW
        NhQakH0AJ2hABazsLbLzXMHhV90sToiUeKycgjN/QKOoPg6AyvZxYIzbk6nkIw==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-lwnkt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Snatch: 4f50e85e2d4e2031_1655425080490_3773561963
X-MC-Loop-Signature: 1655425080490:986981797
X-MC-Ingress-Time: 1655425080490
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.179 (trex/6.7.1);
        Fri, 17 Jun 2022 00:18:00 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPKPg1GcPzCY;
        Thu, 16 Jun 2022 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655425080;
        bh=+/SlzhiUqodCSKW9AbFuoqssPBdtJH4ycGuoP57nzQU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Vt2UCbNl8bSDIPSI690QhD5DV9dIO/uaxT9gM3RbE7Oa8YAwRS0XiN0oglKSCJiY8
         RFUL4Dtuf6ZzAnTBiHZfGT41ekm/sWDOtmUFXB+4vVYMgyFGeBUGLiwKZm7eT140VT
         yFmxPpNlJx8sMhfs/RroLxkFgMxpRbflHwJBgVXXXlMIy687aeYdBUFsTRWugNOGg5
         VMfI8EJWzimVQtbKT9HZuGcoeEvancPVBuKspnRRxAvLzzdDFw21AyTHzotzUxEY3k
         WLCwsqpDZScPwt2yfWS+nhs5Hf+/lxGEdmq7j9yZRlxMxl2LA0JtpZe40H8F62m52J
         zb+kmgon9uMOA==
Date:   Thu, 16 Jun 2022 17:03:44 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220617000309.padpkbqftftk37b4@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
 <20220616224525.fufa4dnpw4vl344n@offworld>
 <20220616231522.GA1529779@alison-desk>
 <b708b1b0929317b9b087505c3177d830f69066d1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b708b1b0929317b9b087505c3177d830f69066d1.camel@intel.com>
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

On Thu, 16 Jun 2022, Verma, Vishal L wrote:
>Yeah agreed with Alison that cxl inject-error <options> sounds good.

I agree as well, that's a much nicer interface.

Thanks,
Davidlohr
