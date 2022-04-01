Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012554EF6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiDAPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349240AbiDAPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:32:15 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5FFFB47
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:05:31 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1naIq8-0005iv-2h; Sat, 02 Apr 2022 01:05:28 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7q/WYLfPwX8zjo+jAX7XneIFFeWm8YqZD2YIQgdwLpI=; b=RCgr5MgnKVuO+Z80qdX4TnNyYZ
        2b2y9Wz7nxjYWx5IBdsoIRc78r+EOjnlVHHFOY1Pr/3zDL9lgxJc6sg6hmwue/9gv1jos2sD7AllR
        ZSCQKas4FSXnCxUN9Dd2CoR53FsnTmMfFiGDdA2N77/t+3wkEfmtAkucWz85hF4Goh/o=;
Message-ID: <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
Date:   Fri, 1 Apr 2022 23:05:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
Content-Language: en-AU
In-Reply-To: <YkcMofXKr/ZmOSwH@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 22:30, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Apr 01, 2022 at 01:48:13PM +0800, Brad Campbell wrote:
>> That I can do. I didn't crop or grep as I wasn't sure what might be additionally relevant.
>> 2 machines, 2 ports, 4 cold boots. Each time just the Thnuderbolt displays chained.
> 
> Thanks for the logs! It looks like the Apple EFI CM always uses the lane
> 1 adapter.

Thanks for sticking with me. This must be a minuscule corner case that is buried in a dark room behind a filing cabinet.

> Can you try the below patch? Fingers crossed that it solves the
> chaining issue for both ;-) I had to patch the test.c because otherwise
> unit tests fail to compile when enabled.
> 
> This should now setup the second tunnel always through the lane 0
> adapter and thus share the bandwidth equally between the two lanes.
> 
> @@ -1604,7 +1604,7 @@ static void tb_test_tunnel_3dp(struct kunit *test)
>   	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 3);
>   	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 3);
>   
> -	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 0, 0);
> +	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0);
>   	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
>   	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_DP);
>   	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, in2);
> @@ -1612,7 +1612,7 @@ static void tb_test_tunnel_3dp(struct kunit *test)
>   	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 3);
>   	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 4);
>   
> -	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 0, 0);
> +	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0);
>   	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
>   	KUNIT_EXPECT_EQ(test, tunnel3->type, TB_TUNNEL_DP);
>   	KUNIT_EXPECT_PTR_EQ(test, tunnel3->src_port, in3);

These 2 chunks don't apply.
I can't find a tb_test_tunnel_3dp in any of the trees I have (either head or stable). In any case I've updated to current head and applied without those chunks.

This fixes *all* cases on the MacBookPro. Cold boot on either port, and hot plug likewise

On the iMac it cold boots on either port. If I boot with the displays plugged in, then unplug-replug we get :

Apr  1 22:49:41 bkmac kernel: [   24.480306] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
Apr  1 22:49:41 bkmac kernel: [   24.481309] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed

The last head on the chain comes up, the first doesn't.

If I plug the displays in *after* the chime and before the kernel starts up, then both heads come up and hotplug works fine excepting after the second unplug we get lots of this :

Apr  1 22:52:54 bkmac kernel: [   37.313493] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
Apr  1 22:52:54 bkmac kernel: [   37.313513] thunderbolt 0000:07:00.0: 0:c: DP IN available
Apr  1 22:52:54 bkmac kernel: [   37.763482] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
Apr  1 22:52:54 bkmac kernel: [   37.763489] thunderbolt 0000:07:00.0: 0:d: DP IN available
Apr  1 22:52:54 bkmac kernel: [   37.763491] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
Apr  1 22:52:54 bkmac kernel: [   37.763495] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
Apr  1 22:52:54 bkmac kernel: [   37.763496] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
Apr  1 22:52:54 bkmac kernel: [   37.763498] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring

And the thunderbolt ports then fail to respond to any plug event until rebooted.

Feels like it's nailed excepting some DP routing on the Radeon, but I've not been able to put my finger on how that works.
With your very first patch, hotplug works on the iMac.

Regards,
Brad.
