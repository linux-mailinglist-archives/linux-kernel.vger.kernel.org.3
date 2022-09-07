Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA59B5B09C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIGQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:12:14 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C18A1C4;
        Wed,  7 Sep 2022 09:12:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EC296122ECD;
        Wed,  7 Sep 2022 16:12:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a211 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3800D123CE6;
        Wed,  7 Sep 2022 16:12:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662567123; a=rsa-sha256;
        cv=none;
        b=2uNEZDWe4TIJGnsPyzjOv1RYh99aA3v0uCxmyS2NAVhr5IusbxOCVKmBK5RCaoGF+VPrA2
        xOFEAMZsExWsZy3ODj+gN/e4l5xWvIkvGjI1755wgl1YNkZVUsYwQJ3NvVkYTwIUWurcGQ
        eUEhz9TNkBLpZ0PRjJKVJNMuU8QaicWarjTt3oLrXKBF3h1gGWMmREWmCQvRruILZgDuFm
        5uagsr5xmpfPHVMNn3O6Ima0nx3Pv02NP+A/pao0W8r1wBaWaMqVugurzwphcHheJjsNA1
        TAs+x5NdUuramHQGrThn5fORNYMn1lo0swYOgksNAK4ofVNr5cxb+27rhZsisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662567123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=W2V9eSI3mZWRJXTngbOpWmZz58iboKT1Gi/jZ1ryfTA=;
        b=2qgZ1mW4zuTAb9UOZDRDTItVuIhIjCxTQzd/FM4nzLjdXCcpFPK8VYsDu7GoVcPLwuWsbI
        EPnc2DhFXZ8IfyrEIfITwq7+7XR5t/yZVEPRjvHonSbFYjBvtc107H0Mj3JKg0FsILvHrc
        YiNGJffzP0NN0ZJOuB7GB3NhN8Mwm2y9rk2dytKslXuF7VVD5a0EHc9TxOySMmQnn08rat
        I4emMc/Fww4ryzY4zbx/Ew7hxA3y7Xi27zVVJe88y17WUo0A0MDgXG4X/KSbBbyh/kLkF0
        pWUzRQBLTNEz3ECjoV5PF6Q9N+YK+QX5li3feqmxd2SHaXEU4eMytTExQhpZ5Q==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-lvkj2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Abaft: 0cefe4c50e6b90bc_1662567123761_1002551623
X-MC-Loop-Signature: 1662567123761:2011659655
X-MC-Ingress-Time: 1662567123761
Received: from pdx1-sub0-mail-a211 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.108.161.89 (trex/6.7.1);
        Wed, 07 Sep 2022 16:12:03 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a211 (Postfix) with ESMTPSA id 4MN6hd5bGGz2h;
        Wed,  7 Sep 2022 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662567122;
        bh=W2V9eSI3mZWRJXTngbOpWmZz58iboKT1Gi/jZ1ryfTA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=IW5xVG/HPYJX/1asrEtomOOIiTIfqgwIT9nRpQNfeEIDj78dMvMz0SUfjVJr67y42
         g4QmMF6pYmVBs35ukkyy6P4OWxoYQcxl8DJvut7+hA44u8IA0Rgzi7GfpT0ME8h1PJ
         lip/cnSufyf1zlOFhNako43ssVaHADvZw4negLUzJH8gEoiLcdhJQ0gCHoRvJAPDy3
         X64aL/UXI+dhl4HMYaGfvdouUgPhjBGvZyuutkwmi/lmT99j8w4hS+Le6wJ1MyXdAR
         aVFl505YmrLxQsApjU/+tvk0keGtDfjQWcy68kdv08fLiIa2bzi2rWXeQNL8sWCIdx
         fVJfblG/ROPVQ==
Date:   Wed, 7 Sep 2022 09:11:58 -0700
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
Subject: Re: [PATCH 1/15] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <20220907161158.iaqgvqkgvdwoc5l2@offworld>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-2-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-2-rrichter@amd.com>
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

On Wed, 31 Aug 2022, Robert Richter wrote:

>The function devm_cxl_iomap_block() is only used in the core
>code. There are two declarations in header files of it, in
>drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
>declaration in drivers/cxl/cxl.h.
>
>Signed-off-by: Robert Richter <rrichter@amd.com>
>Reported-by: kernel test robot <lkp@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Does this want a

Fixes: d17d0540a0d (cxl/core/hdm: Add CXL standard decoder enumeration to the core)

tag?

>---
> drivers/cxl/cxl.h | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>index f680450f0b16..ac8998b627b5 100644
>--- a/drivers/cxl/cxl.h
>+++ b/drivers/cxl/cxl.h
>@@ -218,8 +218,6 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> enum cxl_regloc_type;
> int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>		      struct cxl_register_map *map);
>-void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>-				   resource_size_t length);
>
> #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> #define CXL_TARGET_STRLEN 20
>
>--
>2.30.2
>
