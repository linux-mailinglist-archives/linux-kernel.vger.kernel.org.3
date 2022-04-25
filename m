Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C1B50EC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiDYWh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiDYWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:37:53 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEAD110946
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:34:47 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A28286C12D5;
        Mon, 25 Apr 2022 22:26:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 149F46C1146;
        Mon, 25 Apr 2022 22:26:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650925570; a=rsa-sha256;
        cv=none;
        b=cNLdxrQFNCSzX0Kh8+qvgkdkGWRH2IG+0cYwyy9n2jsBJO4ZMx/8Iv8HTr7nbwNyaya85A
        r1yuBa9pkBI1Pr8Ge+EBgkNWelHu+CuqIDchB/BJMczL/GdYlhUUn9iBVkBtME9wFGU2tZ
        VRWNV1Iw9lvWVR/Xp96J3Yk2Rn+Ot6J3KhZIT7LXCd/dNN6hW6bKZSsPFlytLA/TEg4qR7
        KIhGdm2b0mUUYQ9kbsf9nnlZqMcmGxQH/wqnpZKLE9O4BsdcaycF8pZN5TKk/ySHXKa2P2
        lzC52vwWVq4FzJmgz1mGNpZnduIXtnjfjacOxOifvLrNcgysRFgLGCYHhB0ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650925570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=wLXv5J7QE2DrW/YnW3muD7xmI1tr1cHpAtIZou57L/A=;
        b=00VaPip4zr6cBBRZfismsvG7iySApppSjavoCvGcJKFtu+YnLwULboHzXT5KrZ8oRm13tE
        yIEn918MCTBBO93Ufe50vsg2u0nPnlKceSSfnC88m3Ad2LSZUSjlJta5mb6xnV++bfDAMc
        qNQYwBYMaBgGYranDpxqT6hHFSF+bxYOwYTxQ2VoiPnr0uMKnb/AyzPMZQ5/026HGxQPvr
        v0FbrzX4ZR0ISOjOAaZCdHwCMD7v/hS8jlOsZ2dDhgnyGelH1ZeBl5Z+lk6V9nTxfRLkj4
        iZdFs85u0cgESNQIohWSW1f1c7rOKGhpCDCR5q21uFStTJ6gsXV1xoUa5hr0XQ==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-fszmn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.219 (trex/6.7.1);
        Mon, 25 Apr 2022 22:26:10 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Slimy: 4af154266df1c3d9_1650925570373_3279931380
X-MC-Loop-Signature: 1650925570373:1445528839
X-MC-Ingress-Time: 1650925570372
Received: from fedora (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KnKNd3Z9xz1SW;
        Mon, 25 Apr 2022 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650925569;
        bh=wLXv5J7QE2DrW/YnW3muD7xmI1tr1cHpAtIZou57L/A=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JqtrkpyseQ2u9cXuD2WJGgD1PtfOCn9JH3a4J5jvi/vqXQdvm3cJQwea8MDneR2ah
         NPF6vRfnyXLI5BKMRhM/Rx3XC2Ji3u+JzFyABa10048woq7hWYkcREtZtbPf9fqjub
         et1P+fVSK9dAGP8+RbWCLJwf0tAzE19MGwco5n8CEiWgGUlF7DQv3xPmpDAGEGIWhm
         Q1+3QXzDqCl2rVvEkEYey8pOCWPPM2TuMKg93aYKrnEb0+YBXzvGPWGLOj6aBmi74H
         +79gNE3iqJC+QikTquIyPAoXJ7SxZpN6RdbzXzEcgou/2Ut9Tw8L6QsAXXCk2KRJZZ
         9TsuePDCEwq+Q==
Date:   Mon, 25 Apr 2022 18:26:07 -0400
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: remove unnecessary double negation
Message-ID: <Ymcf/0H0puiWjoxR@fedora>
References: <20220425145440.146891-1-ian@linux.cowan.aero>
 <YmbClxXo5lwgHYxo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmbClxXo5lwgHYxo@kroah.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 05:47:35PM +0200, Greg Kroah-Hartman wrote:
> This is a common pattern to turn any value into a boolean (0/1).  The
> fact that this is a boolean to start with makes this change not affect
> anything.  So you should say that in the changelog, the values are
> obviously not negated.
> 

I just resubmitted with that change.

Thanks!
Ian
