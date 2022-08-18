Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8C598CED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiHRTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiHRTxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:53:34 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481735725B;
        Thu, 18 Aug 2022 12:53:32 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BCE373F131;
        Thu, 18 Aug 2022 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660852410;
        bh=AEGPmEOffVmFLfo5EQMvP4EHxb20JDI4ImU5iKXJP5k=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=IkkWXzyW4VifP84STO73EOBFCXRtXS85Gl4I/ZEjOa+bWwls3WofcCVktqykjR9VY
         0EIJ3LA2pj7bTmGBGF5GamImIiQfHzYS+o9idz3p2S81lVjWah9IFCwx5ptLDGm8+N
         CfeYPe1eou9a/i5+1GQ2mgSjaWI3f+DaTnrz3RpqYNIQnFJetDsQzgD3Qo5QwPxLPO
         dq+tfs2H090pLxxYb5bkSofUZPNhApvqM3KASzBbbJ4BSlcPZ16F2kkCp8YpnOKTRd
         n+eN/0aplVvMbJ1hS7Lr60e/qPBkicbzLRrfcvqQsnGnKy0GFAjrR6r+VWMwo5K7XE
         Ue3aAQCZDKx2A==
Message-ID: <9e6a7216-9cb9-cba4-f150-1a0eaf56353c@canonical.com>
Date:   Thu, 18 Aug 2022 15:53:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        bigeasy@linutronix.de
Cc:     peterz@infradead.org, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [RFC} Commit 8a99b6833c88 Moves Important Real-time Settings To
 DebugFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some Ubuntu users are using the tuned package with a 5.15.x based 
real-time kernel.  Tuned adjusts various sysctl options based on a 
specified profile.  This userspace package has stopped working > 5.13 
due to the following commit:

8a99b6833c88 "(sched: Move SCHED_DEBUG sysctl to debugfs)"

This commit moved some important real-time sysctl knobs to debugfs in 
5.13-rc1.  It also appears some of the sysctl options were not moved, 
sched_min_granularity_ns, for example.

I was hoping to get some feedback on how to approach this.  Would 
upstream real-time consider accepting a patch to the 5.15 real-time 
patch set that reverts this commit?  Or a new patch that adds the sysctl 
settings back?  Any other ideas or feedback would be appreciated!


Thanks in advance,

Joe
