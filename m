Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95552BB18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiERM17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiERM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:27:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE1AFAC7;
        Wed, 18 May 2022 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QJsVQym+xL0e9ZE8cs4o3sRq3C2RnAjl/FhXvupRFQ0=; b=D/Bh+Gmzw2BN6pBNp567gS2D0/
        VKxeDUt7MYxt68TtoX3genmgLQ2oeiNNKiP0kGjaIGmiJfJjrDvbEDObjF99Cs6dMhZ6RnHqXVH7+
        ssMEbATCPWp8/NOivDUP4Rv4NAL42rgZGvDejwV1CjptmTPve2x2GjNuMuzzwvPD0tOg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nrIld-003K4e-Dv; Wed, 18 May 2022 14:27:05 +0200
Date:   Wed, 18 May 2022 14:27:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, maz@kernel.org, axboe@kernel.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com,
        pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org,
        tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 4/6] mm: swap: Add randomization check for swapon/off calls
Message-ID: <YoTmGREvHTpTeeUH@lunn.ch>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-5-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652860121-24092-5-git-send-email-quic_vivekuma@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:18:39PM +0530, Vivek Kumar wrote:
> Add addtional check on swapon/swapoff sycalls to disable
> randomization of swap offsets if GENHD_FL_NO_RANDOMIZE
> flag is passed.

Is there already a flag in the image header which tells you if the
image is randomozied or not? I assume the bootloader needs to know,
doing a linear read of a randomized image is not going to end well.

      Andrew
