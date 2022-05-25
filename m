Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BDF533984
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiEYJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiEYJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:06:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A300986EA;
        Wed, 25 May 2022 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aytZGHL355zCILKlDlAi55WV8/cPE4V7Zd3KNNFli8M=; b=NOIgdNzY8ZBAFLYH297kCYDypt
        AdYAJrJVvAu83LlqfVnmjxPiEWYzD/GoJJmuYRk/q4wPFwGvk0hjwXzrkcJ//+k5n/Zo9MnzVPe6h
        PECJBVytALrBXZSdl7JB0cTlggz9HnLa35J7WFNme1ZFdtZkJsJ563uKsa84yPQkNsXcbIoHNbXGw
        4h/uhpXRPKn46LWy2YhuPaJ9V/kDpI6axmKLQgB5mbrPEkavlJigcbL72L/W70fLwjmlXUCwReAwB
        Ts3sjYcwk7Bhzckvbge09C7h8/jUlc+OaGTgf3rkPUIIDWTKIk13Gdc3VaKgvu94tfPnoc5rMVekv
        iatzWMqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntmwL-00AWIV-7j; Wed, 25 May 2022 09:04:25 +0000
Date:   Wed, 25 May 2022 02:04:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
Subject: Re: [PATCH 3/3] ahci: Document the loss of hotplug by new LPM policy
Message-ID: <Yo3xGRqkfrh7joIR@infradead.org>
References: <20220524170508.563-1-mario.limonciello@amd.com>
 <20220524170508.563-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524170508.563-4-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 12:05:08PM -0500, Mario Limonciello wrote:
> Per AHCI spec v1.3.1, "7.3 Native Hot Plug Support", once LPM is
> enabled hotplug support needs to be disabled.
> 
> The LPM code always followed this and disabled the port when no
> drives were connected, but as more machines will be exposed to
> this code it might be an unexpected behavior to some users.
> 
> Add a note to parameter documentation to explain the new behavior.
> 
> Link: https://bugs.launchpad.net/bugs/1971576
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e6bd212004d..4dcd9a3ba4a5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -279,6 +279,13 @@
>  			3 => Medium power with Device Initiated PM enabled
>  			4 => Minimum power
>  
> +			NOTE: Enabling LPM when no drive is connected will disable
> +			the port which means hotplug will not work.
> +
> +			If hotplug is an important use case, this can be modified

This has two overly long lines.
