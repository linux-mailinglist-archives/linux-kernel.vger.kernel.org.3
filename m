Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D004959FEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiHXPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiHXPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:49:37 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC830AE4C;
        Wed, 24 Aug 2022 08:49:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 46BCC3C1537;
        Wed, 24 Aug 2022 15:49:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a272 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A8E253C0446;
        Wed, 24 Aug 2022 15:49:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661356169; a=rsa-sha256;
        cv=none;
        b=cu+o5/F1M8oKJJd3Cb1g5dj0+jtfKIbltlxaohXPKX70qy/US83bzr4rjx126amUdBi8n/
        0FyHDETA3K7ylQna1mq9ej2UDDhZizPSj8pXPVLC13CaPWPv6iR3jINiOSicT9Zdq8PHx7
        aryG06pXKtcpPj4V8CHz0OpZ/ZtL4VSWJwPSbPnI1CqQgyirUZ55uYFgjNFGV9+PtDg/Hc
        DkXHvcVtalzK3WqS+zl2t6wgYjCTe9/BR/taWx1yQWF++Mr95ZHF84YH2cB49rlYlwj+vc
        hIQulx3PRREWLN5dz0zM7Csb/njLi3uycTf8UpGLChl04CPA6vfs+rRU6lsIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661356169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=f8zvgpAQ/vOOCAA6BsteItnQintQryatUs+B9WSkV00=;
        b=jTUPY3ohRb5pC/6MgkVbIUiJltXIQmi/q2jcDJF189xLhTlcwddDN6Qh8jqTJ5FSaZOZ1K
        Ukz72PHrGELo4ciuaLk/vA9/x5Hr0v/IqvoHMQgw4NjDbUZrJ8R0nz4CSzeCanJ5bC2GNO
        kI5PLgjoBYeJPOwZtxvy+oETZGh+LyfuHhWLjZv3PuXSzrARH7ezylqgWdm1ue6vzNJu8Y
        a88zCjt9rDFDBVbNKmvzGPnPWR5V0BsLGLweZa2Gtn+eAy9KqOEYxPdnCc6v7FKuQy56XZ
        tX6X/cla/ho0HOuRN8uC+5PF/rQ7GT8G1ooGfjZgKFF3UvqrRhnY4VEhTMJM7Q==
ARC-Authentication-Results: i=1;
        rspamd-5cbff9fff7-55tb6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Average: 1edba8120ba38851_1661356170002_2449178677
X-MC-Loop-Signature: 1661356170002:1405177085
X-MC-Ingress-Time: 1661356170002
Received: from pdx1-sub0-mail-a272 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.219.74 (trex/6.7.1);
        Wed, 24 Aug 2022 15:49:29 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a272 (Postfix) with ESMTPSA id 4MCVs473t5zCv;
        Wed, 24 Aug 2022 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661356169;
        bh=f8zvgpAQ/vOOCAA6BsteItnQintQryatUs+B9WSkV00=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KZk2ksKNEUDT32Rd3tpDfFxsY0TRFy+bGHBa4znHeeVbLOWCqdV2FNTTu9B8eezou
         HPkEHlIKLekVraT3q9sdv32aLYNFlF49NA5VJeo4vKinBlI7PvoEaLEOkN50lyMWMJ
         tuvbbr0rgqpXK1ajE99YjWn2MNX82Nw8oycR+U7Q2klt93JM0OXACYDrGPCaUEu9L+
         Ih6q6jvT65kzrmGWQ0Jen51ed2az3IDA1MeIViF6V6y3ctT6u3XDzdjDyymZfzyLZ8
         Do8l9+xJ0QGtEA5Yx7+KAZaLQYplKZEfPICn7Slz4MD+zhWQNcYeFm3U77Y0o/7WaN
         Z9MXfwmcsdLDg==
Date:   Wed, 24 Aug 2022 08:31:22 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Message-ID: <20220824153122.2bgths6lnsxlolos@offworld>
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
 <20220822170510.125082-1-a.manzanares@samsung.com>
 <20220822171703.sfizbmn6retpxggi@offworld>
 <20220824104401.00005cd4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220824104401.00005cd4@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022, Jonathan Cameron wrote:

>On Mon, 22 Aug 2022 10:17:03 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:

>> Actually the whole drivers/cxl/* could use updating the comments for 3.0.
>
>Interesting point.  What do we want to do on this?  Most similar
>cases I've been involved on rely on referring to 'oldest' compatible spec.
>(this is true for ACPI stuff for example).

I find it incredibly annoying to reference table or section numbers from old
specs mention in the code. Unless dealing with specific version things, why
use old specs at all?

The main drawback to this is obviously the constant need to update everything,
so...

Thanks,
Davidlohr
