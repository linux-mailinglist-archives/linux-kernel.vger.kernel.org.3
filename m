Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44A481E61
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbhL3QzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:55:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33908 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhL3QzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:55:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3248C1F37D;
        Thu, 30 Dec 2021 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640883304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4dCuCPa0ZYPYoQqfFtxCOaA2HE9+JrhrlVbla/OFt4=;
        b=zbz7H9R+J7sLEqOWG4iYbGZmI3GuzR29h6NfAV+Z/r3xJ6mpgW7S6kEWdPLsEU2Dq82NQx
        VuSRlQk1AZyYbg6Ob6FMeJIcvBRofzrT+xblQ1xORP0S9YohhyMc3exGbHDxqNKMEbNfWy
        N1Kq6fEapg4JOYilASseXlYMclUJTrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640883304;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4dCuCPa0ZYPYoQqfFtxCOaA2HE9+JrhrlVbla/OFt4=;
        b=49vo+Bcyc6blkS2qdV3TRt1uRZq7SnJ6HVqBe5d4pFbYTF2DFyUVBoD6z/CRGkm2rQGgJ+
        Cv0TG4xcpES2lPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 106B413C0B;
        Thu, 30 Dec 2021 16:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KeaDA2jkzWHyfgAAMHmgww
        (envelope-from <bp@suse.de>); Thu, 30 Dec 2021 16:55:04 +0000
Date:   Thu, 30 Dec 2021 17:55:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>, linux-pm@vger.kernel.org,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v7 02/14] x86/msr: Add AMD CPPC MSR definitions
Message-ID: <Yc3kbiZWeLBcCrw9@zn.tnic>
References: <20211224010508.110159-1-ray.huang@amd.com>
 <20211224010508.110159-3-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211224010508.110159-3-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 09:04:56AM +0800, Huang Rui wrote:
> AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> registers to manage the performance hints. So add the MSR register macro
> here.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
