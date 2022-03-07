Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002084D023D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbiCGPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiCGPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:01:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13F33A19
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:00:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l12so20785292ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lJtjgve15KcPn5Fu9Ouzt1Wk99mJhKfetxwppVZu8NU=;
        b=rwzKJtfJcICD1GmZEURxv1cmkMof2PEdjv5T839FXmnrp5OrFhLyJki6sy+pSUlouq
         FkJcaTnPE0OsYdLxfzl1mZfg32F7cWz3dib3rPMfKtItblXggw3jt/GNeSww2Ef8C0uL
         gyCBWhvKdWplhwbMHUjSVg/A4U3pOa2AEFqs0Phgz4YKo4ofnItLOnnsOFPyfe5tuG9c
         SRp17Nn+DG+7vAp6nAiUeZ0nlmc/T6scQ7SoFo96XmvP3lxxmN6LV8/n9/JTppfaLVe9
         8HNaUTibEAkvzt7SOMwMxVQpx7SIgwmp4x7xJ+DAJcInoaBFW8aYsQ1N6wiUFHnDl3qU
         mGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lJtjgve15KcPn5Fu9Ouzt1Wk99mJhKfetxwppVZu8NU=;
        b=gK0NX8QvFNyKvn+nennTk0s4+hOyotLp9ReP0ycHR+mpFLHsMWZClWFsU3mEgwovkn
         QOL+qkaXLoUN4sr3TWO9TFai/+k+ZtgLPth+VJ4cK6XvTCYlWEi9Pc75OznrnCh3OyPr
         JGXNShZkszkUpperCBhLPWG/nK6GpAwqtDenBBzf1csPJSa9h6kr01hnUlpyZO+x2iFK
         5VQL/WVGJJgWFSGOWjHkt3wvokJOl32mXXzuGQ6jYhxD5kMYG9OW9YSGw/e8HubxSjp0
         nmnmJqwV5V8VTPlqYAO3xFXmvQ5umnECQVDY/4DkWUp9z14yw2ZQcyV7K9faI1Cu1Y9r
         SeGg==
X-Gm-Message-State: AOAM532290SqN7A/CJcrqyR7aNiZEYnis1YFiD5uE255o5Usdbp1VdTv
        jCXtWocFixVsqLdNxvoyFz2LbQ==
X-Google-Smtp-Source: ABdhPJz4S0r8jeA4pBXHSvd68+6vZd78S3Itpg6kY1EELmS5SoYS0Tra6J0HwgxD0edOvclP8e5G3w==
X-Received: by 2002:a05:651c:a0e:b0:247:daa7:4357 with SMTP id k14-20020a05651c0a0e00b00247daa74357mr7281184ljq.180.1646665224088;
        Mon, 07 Mar 2022 07:00:24 -0800 (PST)
Received: from wkz-x280 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id bi25-20020a0565120e9900b0044757d26a47sm2498865lfb.290.2022.03.07.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:00:23 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
        kuba@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Petr Machata <petrm@nvidia.com>,
        Cooper Lees <me@cooperlees.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 net-next 03/10] net: bridge: mst: Support setting and
 reporting MST port states
In-Reply-To: <53EED92D-FEAC-4CC6-AF2A-52E73F839AB5@blackwall.org>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-4-tobias@waldekranz.com>
 <53EED92D-FEAC-4CC6-AF2A-52E73F839AB5@blackwall.org>
Date:   Mon, 07 Mar 2022 16:00:22 +0100
Message-ID: <874k49olix.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 00:19, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 1 March 2022 11:03:14 CET, Tobias Waldekranz <tobias@waldekranz.com> wrote:
>>Make it possible to change the port state in a given MSTI. This is
>>done through a new netlink interface, since the MSTIs are objects in
>>their own right. The proposed iproute2 interface would be:
>>
>>    bridge mst set dev <PORT> msti <MSTI> state <STATE>
>>
>>Current states in all applicable MSTIs can also be dumped. The
>>proposed iproute interface looks like this:
>>
>>$ bridge mst
>>port              msti
>>vb1               0
>>		    state forwarding
>>		  100
>>		    state disabled
>>vb2               0
>>		    state forwarding
>>		  100
>>		    state forwarding
>>
>>The preexisting per-VLAN states are still valid in the MST
>>mode (although they are read-only), and can be queried as usual if one
>>is interested in knowing a particular VLAN's state without having to
>>care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
>>bound to MSTI 100):
>>
>>$ bridge -d vlan
>>port              vlan-id
>>vb1               10
>>		    state forwarding mcast_router 1
>>		  20
>>		    state disabled mcast_router 1
>>		  30
>>		    state disabled mcast_router 1
>>		  40
>>		    state forwarding mcast_router 1
>>vb2               10
>>		    state forwarding mcast_router 1
>>		  20
>>		    state forwarding mcast_router 1
>>		  30
>>		    state forwarding mcast_router 1
>>		  40
>>		    state forwarding mcast_router 1
>>
>>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>>---
>> include/uapi/linux/if_bridge.h |  16 +++
>> include/uapi/linux/rtnetlink.h |   5 +
>> net/bridge/br_mst.c            | 244 +++++++++++++++++++++++++++++++++
>> net/bridge/br_netlink.c        |   3 +
>> net/bridge/br_private.h        |   4 +
>> 5 files changed, 272 insertions(+)
>>
>>diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>>index b68016f625b7..784482527861 100644
>>--- a/include/uapi/linux/if_bridge.h
>>+++ b/include/uapi/linux/if_bridge.h
>>@@ -785,4 +785,20 @@ enum {
>> 	__BRIDGE_QUERIER_MAX
>> };
>> #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
>>+
>>+enum {
>>+	BRIDGE_MST_UNSPEC,
>>+	BRIDGE_MST_ENTRY,
>>+	__BRIDGE_MST_MAX,
>>+};
>>+#define BRIDGE_MST_MAX (__BRIDGE_MST_MAX - 1)
>>+
>>+enum {
>>+	BRIDGE_MST_ENTRY_UNSPEC,
>>+	BRIDGE_MST_ENTRY_MSTI,
>>+	BRIDGE_MST_ENTRY_STATE,
>>+	__BRIDGE_MST_ENTRY_MAX,
>>+};
>>+#define BRIDGE_MST_ENTRY_MAX (__BRIDGE_MST_ENTRY_MAX - 1)
>>+
>> #endif /* _UAPI_LINUX_IF_BRIDGE_H */
>>diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
>>index 0970cb4b1b88..4a48f3ce862c 100644
>>--- a/include/uapi/linux/rtnetlink.h
>>+++ b/include/uapi/linux/rtnetlink.h
>>@@ -192,6 +192,11 @@ enum {
>> 	RTM_GETTUNNEL,
>> #define RTM_GETTUNNEL	RTM_GETTUNNEL
>> 
>>+	RTM_GETMST = 124 + 2,
>>+#define RTM_GETMST	RTM_GETMST
>>+	RTM_SETMST,
>>+#define RTM_SETMST	RTM_SETMST
>>+
>
> I think you should also update selinux  (see nlmsgtab.c)
> I'll think about this one, if there is some nice way to avoid the new rtm types.
>
>> 	__RTM_MAX,
>> #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
>> };
>>diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
>>index f3b8e279b85c..8dea8e7257fd 100644
>>--- a/net/bridge/br_mst.c
>>+++ b/net/bridge/br_mst.c
>>@@ -120,3 +120,247 @@ int br_mst_set_enabled(struct net_bridge *br, unsigned long val)
>> 	br_opt_toggle(br, BROPT_MST_ENABLED, !!val);
>> 	return 0;
>> }
>>+
>>+static int br_mst_nl_get_one(struct net_bridge_port *p, struct sk_buff *skb,
>>+			     struct netlink_callback *cb)
>>+{
>>+	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
>>+	int err = 0, idx = 0, s_idx = cb->args[1];
>>+	struct net_bridge_vlan *v;
>>+	struct br_port_msg *bpm;
>>+	struct nlmsghdr *nlh;
>>+	struct nlattr *nest;
>>+	unsigned long *seen;
>>+
>
> Reverse xmas tree

Both of these lines end at the 28th column. Is there some other
tiebreaking mechanism that forces the reverse ordering of nest and seen?

In a variable-width font, the nest declaration does appear shorter. I
remember that you did not have your laptop with you, could that be it?
