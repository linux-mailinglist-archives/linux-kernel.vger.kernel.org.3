Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F87575672
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiGNUkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGNUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:40:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1E4AD59
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0UbINprXHIcKJelLt5cQiiEIcF3SWv0kgbs5wFpce5I=; b=OwTfcA+5EOw+rzbYKBLqpXAZIC
        vPcNmmcZack8E6GSTNiHw43ysh8Zhj/EGmfvoM6Ikgyc8OMwPOpcDXU/Ol42zfclAX6q6e6/Fde63
        vKBDFPpxP4L2LTx4MBAz0kk95+xez6SjmQWzLvGXIJVSchN+1mW/93EAWGdKQNHOiszJPbBqKaGdT
        2XlDj+oIAmc7Zsqyd7S645/JI/IQCmd+LcS2wsPXG27vMcyFEuVsXK5fjbAebyNnaSnOhCmjr938x
        DTjmUrOaJA8OREiHqIIQEM18N2I71XQQ5OlA6ZQ6lRenwurwx0Bn/GzGi4nOTEnfY6oISlSWP0yTa
        3anW2NUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC5dQ-001WE8-Ba; Thu, 14 Jul 2022 20:40:32 +0000
Date:   Thu, 14 Jul 2022 13:40:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Message-ID: <YtB/QJw84z7mh0dr@bombadil.infradead.org>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com>
 <1891319.taCxCBeP46@opensuse>
 <Ysq+rpkTU1/nquHo@kroah.com>
 <2140056.NgBsaNRSFp@opensuse>
 <YtAtQihwVrdymfOX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAtQihwVrdymfOX@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 04:50:42PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 11, 2022 at 08:52:49PM +0200, Fabio M. De Francesco wrote:
> > 
> > I see that the outputs of selftests, regardless of running a 5.19.0-rc6  
> > kernel with or without my changes, show always the same error:
> > 
> > "not ok 1 selftests: firmware: fw_run_tests.sh # TIMEOUT 165 seconds".".
> > 
> > I ran those tests on a QEMU/KVM 32-bits VM, booting a vanilla 5.19.0-rc6 
> > kernel with HIGHMEM64GB enabled. 
> > 
> > As said, outputs don't change with or without my patch. Instead it changes 
> > with the latest openSUSE stock kernel (5.18.9-2-pae):
> > 
> > "ok 1 selftests: firmware: fw_run_tests.sh".
> > 
> > Unfortunately, I'm not familiar with kernel selftests. Any ideas about what 
> > could have made this tests fail? Is it expected? 
> > 
> > If not, I can try and figure out why these outputs are not what they should 
> > be (the second version of my patch can wait the time it takes).
> 
> No idea, sorry, Luis might know more.

The selftests should have a config file, ensure that stuff is all
enabled. Can you verify if this stuff was enabled on your config:

cat tools/testing/selftests/firmware/config 
CONFIG_TEST_FIRMWARE=y
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_FW_UPLOAD=y

  Luis
