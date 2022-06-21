Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C8553EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354953AbiFUWxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354897AbiFUWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:53:06 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D8636B;
        Tue, 21 Jun 2022 15:53:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6AE88820ED0;
        Tue, 21 Jun 2022 22:53:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C007F820E8B;
        Tue, 21 Jun 2022 22:53:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655851983; a=rsa-sha256;
        cv=none;
        b=PF9HA+66TC3A4hl6jKjHZ8gU0KsxS7GyiIVMYKn2B+VnMcIwYa2ZwAgUlPMo9mEJACqq1M
        KbQh7oM4oyAfSkn/S8yITWdB5Cm+g8TrOUd1i/89ju/gQh1lDsDnlA7nVF/iboy0bba2K/
        1AoE5geHYFKP5MjdyfzgLxrk678hgHJdgzFvdPRDd0jHk43r6sq/XZJ9ZEE0WRNOyQYJHR
        FbMpIM86SD+L6iEjTlDaHZXTUycBHl3B0nlkWfX0GNeXFmGQJnsxG+kekTleX75tPMKvF9
        z1bsQoAgWnt6gc6ClB+rqnMmt3htVk5HmFvc7kNRGOp9Vo0REgmBoLK8SXOqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655851983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=DuRoRhUDaZz2pGPqMmDaVozhJJ1+RdhvflafaG1sedQ=;
        b=5stPAB+iMY6QqAi79Dq22/kEsF8Figc0seLjtnDe7NkLlGMbLCQrxo6tYbKlKnWwVbO/BJ
        JdDh9GJcPuMdOS/Abxp4Zw4i8t63jMSpUJN2WeqHMDqUQh3xyvfIY34bgOJNviTHvzi8iz
        CmfTnhhxYoG1sPu26xqb3t7E2bV2MTa5uNPVc+4afTTdfgc/FAcqYLHd+2vFEimI70zWjP
        uRjhWMBLjRc6Z+3mVG06qLMss6YZC64q96o5GxxwIPtOWzN7Gcswa7hPTsLp6tjaINbcdX
        3Tvv9zhdHGzbF0DhDwIV1vUBURODsUbLA7+iJY2TXHDoudoPic6dVbsMVuO+uA==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-w6m4h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Towering: 68ad26a17b01508e_1655851983210_907247294
X-MC-Loop-Signature: 1655851983210:2905729898
X-MC-Ingress-Time: 1655851983209
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.98 (trex/6.7.1);
        Tue, 21 Jun 2022 22:53:03 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4LSMHK248Mz29;
        Tue, 21 Jun 2022 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655851982;
        bh=DuRoRhUDaZz2pGPqMmDaVozhJJ1+RdhvflafaG1sedQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=dL4fPV+GH8+lxgeE42JwEz0Gzk2h8DEsKoYimsk3UP6d6XyHYJ9qyrPFU9qpWu0tT
         ivdl2onbnmgOKJyyX9Cyjm5Oy88bHf11z7fCB1u//ZvTA8cDLZPDQOW2a7lge49qr4
         eqKaMiEdPsJlR+SXk5sQwT392J1fWcq0T6qvgI51eXStYMIqy9+fv0HZCNRluNid3f
         AC2I1ZiF89wt9MThlIKfb7FBfO0BQya868AXZiRtv03fla7zDHekpyvn5xHrolnBCx
         +9+O6J9HbG5fCvzdhuJN9Q9BA4R2ma41NjHa7+CVs0g2wO+BKjKoLeC/Py/UCanVHh
         5LGkb++4PcXzQ==
Date:   Tue, 21 Jun 2022 15:38:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Verify CHBS consistency
Message-ID: <20220621223829.zdyqoej76kyfut4o@offworld>
References: <20220621201259.1547474-1-dave@stgolabs.net>
 <62b230881a77_8920729456@dwillia2-xfh.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <62b230881a77_8920729456@dwillia2-xfh.notmuch>
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

On Tue, 21 Jun 2022, Dan Williams wrote:

>For cxl_port objects this happens "for free" as a side effect of the:
>
>        crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
>                                   CXL_COMPONENT_REG_BLOCK_SIZE);
>
>...call in devm_cxl_setup_hdm(), where it tries to exclusively claim the
>component register block for that cxl_port driver instance.

Fair enough, I had noticed this.

>
>I.e. if the CHBS provides overlapping / duplicated ranges the failure is
>localized to the cxl_port_probe() event for that port, and can be
>debugged further by disabling one of the conflicts.

Ok. Although imo it does make sense for failing directly in the cxl_acpi
driver at an early stage instead of bogusly passing it down the hierarchy.

So is a v2 still worth it without this check?

Thanks,
Davidlohr
