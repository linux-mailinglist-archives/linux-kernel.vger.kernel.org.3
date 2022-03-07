Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAE4D0222
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiCGOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbiCGOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:55:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238368A6C5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:54:23 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z26so12628108lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yZXiD6hS6mJeLTwuxQbRhcKg3gd8jZak9MF/XHZfC80=;
        b=PInE7sNH3FAw4VBYjgCxQeCZGyzeISgqmm8oc6aAxEeLc57fWstxSXYsgSHoUoPc1H
         aBUk2pP6pp1/zBjKwlLgLVhICf0t97exUkqTqsYQ2AP0gQ74x9Rf8hNxwNNdSiduM+gG
         KfiFkcKz5VQY2HEuMc38UuAQWb40syXvkBYBVLg/5t02c/Un500zw1s6i4B9AHc4YHEb
         w4bItCDYpunWpwvsj8/4gQouWrfhtWGtQTE2rOZOCJRL5VhOfRGkBmFFqcNm3YlH4IIw
         ZRK8JFB4qmi8vJcAKp/u6YB14RU4Z5lBM9HIsLlMNnqlFaHrUCcdgVLmylgRZXp8thDt
         tbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yZXiD6hS6mJeLTwuxQbRhcKg3gd8jZak9MF/XHZfC80=;
        b=DU34tBlzJ7/fpawjG+dudm4PrAxv7qvndrkT4xhcXzaF+3HkN1pc0yG6b8dHoJBBtR
         9D7Moz2572hWmAEBm4NHz2c33Mtq0ONCzOB4qzCBD413wCZ8BJ719llgVvoU6lfK2uWl
         k299yqHrPbaEqN18Y1V/mF4P0krSw00D0hzf53tFN/S0jCVAbizHxYWbKcJ/jt3j3Okt
         jROtTZug0dM2bGuJgjwYzAOkz7lnh9P3pSMDjXVYLQxHCbQv4OtyOdkaXN6dM+KJX7un
         FFsWWCsrj9I3iKkLRvsZiEqlNMDHoY1h7uu18bZH/K+uZKKVLTMlOa8uIDMHJVwIBcbt
         XMsQ==
X-Gm-Message-State: AOAM533pc8tIblfKteZrwxAnuRx4pvjwN7D75EoPM1TRp6PlcepfntSb
        PiEOQ1PPM1FeCjaUzAHR4mne9Q==
X-Google-Smtp-Source: ABdhPJwuV83TcfVQxlPEaU4xjxNDO5xJ1kFMKI6p1CPlavmun9vuyCu39TiRhPsVovuCSNgUweVDjQ==
X-Received: by 2002:a05:651c:514:b0:246:8b8c:a97b with SMTP id o20-20020a05651c051400b002468b8ca97bmr8227623ljp.238.1646664859059;
        Mon, 07 Mar 2022 06:54:19 -0800 (PST)
Received: from wkz-x280 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm1946043lfn.240.2022.03.07.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:54:18 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Russell King <linux@armlinux.org.uk>,
        Petr Machata <petrm@nvidia.com>,
        Cooper Lees <me@cooperlees.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 net-next 02/10] net: bridge: mst: Allow changing a
 VLAN's MSTI
In-Reply-To: <20220303222742.si2gksy3tzagsc7r@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-3-tobias@waldekranz.com>
 <20220303222742.si2gksy3tzagsc7r@skbuf>
Date:   Mon, 07 Mar 2022 15:54:17 +0100
Message-ID: <877d95olt2.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 00:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 01, 2022 at 11:03:13AM +0100, Tobias Waldekranz wrote:
>> Allow a VLAN to move out of the CST (MSTI 0), to an independent tree.
>> 
>> The user manages the VID to MSTI mappings via a global VLAN
>> setting. The proposed iproute2 interface would be:
>> 
>>     bridge vlan global set dev br0 vid <VID> msti <MSTI>
>> 
>> Changing the state in non-zero MSTIs is still not supported, but will
>> be addressed in upcoming changes.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>
>> +static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
>> +{
>> +	struct net_bridge_vlan_group *vg = nbp_vlan_group(pv->port);
>> +	struct net_bridge_vlan *v;
>> +
>> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
>> +		/* If this port already has a defined state in this
>> +		 * MSTI (through some other VLAN membership), inherit
>> +		 * it.
>> +		 */
>> +		if (v != pv && v->brvlan->msti == msti) {
>> +			br_mst_vlan_set_state(pv->port, pv, v->state);
>> +			return;
>> +		}
>> +	}
>> +
>> +	/* Otherwise, start out in a new MSTI with all ports disabled. */
>> +	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
>> +}
>> +
>> +int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
>> +{
>> +	struct net_bridge_vlan_group *vg;
>> +	struct net_bridge_vlan *pv;
>> +	struct net_bridge_port *p;
>
> No attempt to detect non-changes to the MSTI, and exit early? In a later
> patch you will also notify switchdev uselessly because of this.

Yeah you're right. Will fix in v3. Thanks
