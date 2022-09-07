Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F25B0C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiIGSWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8CB6D3C;
        Wed,  7 Sep 2022 11:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E85CA619FC;
        Wed,  7 Sep 2022 18:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21840C433D6;
        Wed,  7 Sep 2022 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662574960;
        bh=Pkr1VvhGYTg8QJDpcdOK6Hab6jKDX9QoWXLoxDwLXps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pf0ROvV8VgS0K2jblECNPhnHxkA09Cg+w+nZrcEdk+FC7o03qj7YRfJLQqvCvJ0jl
         i9q/JgljJ3sXgmcEPVdZbjtOaYPoGHoHi5Qpc3hVh/+k298XtQmsAjlRhTPp6/0eAG
         PLFejE8hcJ3JRmqNkBC0zr7ipdCXuEfkOadpl34rkgmrEV8w5PoLaO46ZFeuofMOHR
         ATEAY9IrQWdIp+kS6VQBIKMUsBaVZVmDmjN5MKEtwwOsr/bISzBkb94DNKNCFvqRkY
         ocdkTM1mKQPBqUXA+p5RLNvaJ9PmSnzi/WnyhSs6ViGJDLl0Gzh8pEZE6ibe7Ri7HF
         wgm/YE4yFUmtw==
Date:   Wed, 7 Sep 2022 13:22:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted
 CXL hosts in RCD mode
Message-ID: <20220907182238.GA134795@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-6-rrichter@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:15:53AM +0200, Robert Richter wrote:
> Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
> enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
> host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
> ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
> it with a description of the CXL device.
> 
> Add function cxl_restricted_host_probe() to probe RCD enumerated
> devices. The function implements a loop that detects all CXL capable
> ACPI PCI root bridges in the system (RCD mode only). The iterator
> function cxl_find_next_rch() is introduced to walk through all of the
> CXL hosts. The loop will then enable all CXL devices connected to the
> host. For now, only implement an empty loop with an iterator that
> returns all pci host bridges in the system.
> 
> The probe function is triggered by adding an own root device for RCHs.
> This is different to CXL VH where an ACPI "ACPI0017" root device
> exists. Its detection starts the CXL host detection. In RCD mode such
> a device does not necessarily exists, so solve this by creating a
> plain platform device that is not an ACPI device and is root only for
> RCHs.

Drive-by nitpicks: 
s/PCI root bridges/PCI host bridges/ to match other uses
s/pci host bridges/PCI host bridges/ to match other "PCI" uses
s/does not necessarily exists/does not necessarily exist/
