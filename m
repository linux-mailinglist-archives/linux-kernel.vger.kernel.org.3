Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02B527AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 00:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiEOW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEOW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 18:26:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9BDEFC
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B4AB80E3D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A0CC385B8;
        Sun, 15 May 2022 22:26:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M+ASSQpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652653601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I64jxOazbkdl/brraTguUZdPdpvixQ8FNX1S54ZBWoM=;
        b=M+ASSQpx4cyVH3pl1uluVCrVUHX0l5RwGWi7/U1XqAeMRHgdaprTCtJNZWaic4cvj1l/dZ
        GXtZGQoQqTQOykU6ND2oHQczWhIV3KWwQJvglzhQHKlaV9nAO/h9EQC/wlPeln0KziMHJO
        uRYb5t0cJ+VfnclaVzP+Joae3uuuqSs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 77615ee3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 15 May 2022 22:26:41 +0000 (UTC)
Date:   Mon, 16 May 2022 00:26:39 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2 s boot time regression between 5.17 and 5.18-rc4?
Message-ID: <YoF+H28BQxoD7rfj@zx2c4.com>
References: <a6688497-e234-ddaa-f371-b9e7539df74d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6688497-e234-ddaa-f371-b9e7539df74d@molgen.mpg.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, May 16, 2022 at 12:09:20AM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Looking at the timestamps I only just noticed a two second regression. 
> The line below
> 
>      systemd[1]: Created slice Slice /system/getty.
> 

Known thing, but not quite a regression, as it does unblock and continue
booting. IOW, there's no possibility it will hang forever. But that's
neither here nor there: your log says you're using systemd 250.4. This
was fixed and backported to 250.5 (and 251 of course), so try updating,
and the issue you're seeing will be gone. If not, do let me know.

Jason
