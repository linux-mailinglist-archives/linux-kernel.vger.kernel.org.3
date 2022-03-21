Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5B4E3338
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiCUWvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiCUWv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6341FA7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10097611F4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBC6C340E8;
        Mon, 21 Mar 2022 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647902513;
        bh=0TiXX+rj7tWcU7Feva2G+b3UK5vwHvZIWYnaJrtBjOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTk4kKnqDee3eBR9ryv1O25YiYUr/Xh+rpQWyMEXu59E4FUpgqWPnuXlcrkG0ri+m
         NuPt/100UNHKeOVata/qcctH1RJWUI0Be8oUJ1mqQafAQ6QwikFSBB973Gsw1mjA6z
         UCFLQixyrK/kuAfFpU2nbKLO9JRlgl2ZOZqw3CC++jVWToJtFkk7Heq2whigQTolBA
         0BGMe5TWkVNw4g0xltJNwkaw5PfkN7ArMMAwHnqA+UEMfQg4WXRRd13g9sFPfm3flZ
         D+WoE/QHbJmEUe1AfqmmbRTF8cEQvVQ1yVmFxfIcXAh/yL1phG6OeqIarkLkMgfUp7
         nK9yE6PtMJnhA==
Date:   Mon, 21 Mar 2022 22:41:51 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce data read/write showing path
 info
Message-ID: <Yjj/L5/kwc5Oo74E@gmail.com>
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321223315.3228326-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:33:15PM -0700, Jaegeuk Kim wrote:
> This was used in Android for a long time. Let's upstream it.
> 

You still need to explain why this is useful.

> +static inline char *f2fs_get_pathname(char *buf, int len, struct inode *inode)
> +{
> +	char *path;
> +	struct dentry *d;
> +
> +	/*
> +	 * d_obtain_alias() will either iput() if it locates an existing
> +	 * dentry or transfer the reference to the new dentry created.
> +	 * So get an extra reference here.
> +	 */
> +	ihold(inode);
> +	d = d_obtain_alias(inode);

Why does this use d_obtain_alias() to get a dentry instead of just using the
dentry of the open file?

- Eric
