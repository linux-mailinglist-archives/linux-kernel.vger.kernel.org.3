Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F954EDBC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379301AbiFPW7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379286AbiFPW7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:59:44 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525962A1E;
        Thu, 16 Jun 2022 15:59:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 987F7121DA9;
        Thu, 16 Jun 2022 22:59:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2039C121D8E;
        Thu, 16 Jun 2022 22:59:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655420381; a=rsa-sha256;
        cv=none;
        b=B85/YcjPapY22mVOAwMM4r5F6nEaSu94rVTx+MvJNpaOn5e+mDWFTOtZjWYyv8Jb3QyHun
        W6bV216mtDytsG0qLvwtgcDDqefR0Rd2btmO0UAjLki/bxnYbaej9F436VvYumKyrbNQM2
        Kjb0TMNvHXWlfAq7hUOj6wSVwqWqBwt20wiHr0q0dn9Bf/1nepthbfbPdNq5+TnRVWFtBy
        d5nx5xULo24gALh0xB3uVnGBYItp4HzDu0Y5p68V1Mxd6Y7AWoTtX3j5MK3AA9b9g98ZLI
        iNzxO+NLBY+EsDEyVj6wo7TrdNAEbVCTt6Okj4xnmDCNQZ4S9UFHu/e77sxetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655420381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KMUJjasGhtZ6xtzJgMJ6iOnVpbo7qM4ta3eH7kPU4uY=;
        b=ybQzlj9KH9kXIUILAj32OwMxa1xTUg72X4S1bIGRT2v58P5an51znBQanqyB/zP/8ORgPr
        6EiHW7fNYXMIhavRHnzncqLh3ShU/ReLluU2PTX/60WRuLvt2mMOrKPnCDD+x3ZWNwKDfk
        xSzz13zX2Lnk9+Nte3cjamZWK1ldTf6PKb/JDrl92h9ul0Znkfot1Vaxvvo2sLbSzkTtRe
        3bq314IJ91aQiBGJUnF96Nxr9dWvg3K03X53gFvGk1M+lWV7oB+X2UHq9h5m9fGXp1g91R
        6AvDkJ8A44A+ejheaVFQ2sDGDMQwjVMd5gNGBiMm/7ZwZ9uWn2errQSyw//iig==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-9jkmw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Duck-Turn: 14413558197c5ca4_1655420381448_582639351
X-MC-Loop-Signature: 1655420381448:1891084837
X-MC-Ingress-Time: 1655420381448
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.213 (trex/6.7.1);
        Thu, 16 Jun 2022 22:59:41 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPHgJ1P4szCY;
        Thu, 16 Jun 2022 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655420380;
        bh=KMUJjasGhtZ6xtzJgMJ6iOnVpbo7qM4ta3eH7kPU4uY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JEO7plbhII07lJxR/lL+83K9pMnfPPGk9KxDsztsv1Rtb3c+hKRIJyPI0PQcp6moT
         h2+oo9gkiQeIGFePYy0BTGhXWjbaRp3X2JIWEJco+mTW0DSvTtabSqQ7SQGbIrbdkC
         os69Zfq2hA5I6jflJjXZIqwVhpqaGFRRZ0S5lxZzXxhLFfH2uUEuU5xN6qHpJQqNzs
         tt6YEYRNptkbguHN5Tu4+SS/KWDty26C7Oz6XMCRecO2mvMfUV7fL6nG/AAAU00iYk
         JGLM+HygCI4HJ3Bm3FLeqrjvxbJ5rLAvMpiQZ+Ohu6bzdT6WEzI4oIFNV0ddxbbdX/
         YHziBk0rNi4Sg==
Date:   Thu, 16 Jun 2022 15:45:25 -0700
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
Message-ID: <20220616224525.fufa4dnpw4vl344n@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220616203400.GA1529208@alison-desk>
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

On Thu, 16 Jun 2022, Alison Schofield wrote:

>cxl list --media-errors -m mem1
>	lists media errors for requested memdev
>
>cxl list --media-errors -r region#

A quick question on the tooling front: the above goes nicely with
cxl-list, but what about the rest of the poisoning cmds? Do you have
anything in mind? Do we want something specific for media and poison
management instead? Ie:

cxl media --list-errors <params>
cxl media --inject-errors <params>
cxl media --clear-errors <params>

Thanks,
Davidlohr
