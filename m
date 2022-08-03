Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A82588615
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiHCDvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiHCDvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:51:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B7140AB;
        Tue,  2 Aug 2022 20:51:11 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so14284760fac.7;
        Tue, 02 Aug 2022 20:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7C+drAHFu3aVfCmipZuQgTZN64nJmjjGVXp4lwHYe/s=;
        b=mVmrrhAew0bo1ZiSFTH4tzdPXMu/14cBKglxCR6y3fc5APF0lauPj4435skZy0Njuh
         WZv9PYyQRQENIRGMkfoa7EePCPyVfjQ2gymOIXa/XJKXTVuQjEJcawthjieVMb6XWhpa
         u1bnVtoNPO2KG3yQkd0Hh2X50W2nu5gGWNcnubLlPf1l0sXOt1rE3D4adnNbslV972eQ
         qfOPtnnfKaNNFVmv2SjgisRTrNzKKKV6AdmV+BGJmkApzr85EuJ/hEp1/4pF5i5fTepn
         CkZsDyLOVe1ehBOzrR/2FUTWnZYYtl7tcZexMKxI2qrs3LfCXjfZ9hS+gaYVRsrFkvgb
         QXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7C+drAHFu3aVfCmipZuQgTZN64nJmjjGVXp4lwHYe/s=;
        b=UM6zBF8VZaXA5tTR3LoxECO89lMnf4gVp34Cg615E1PDofBpFcU+jSp/xwtqE/PzKk
         8KebpUeWEmvhIuUw6yUGLTD2LZxGvoCdbNDlM5JJHR4QokU8hs0JrsokpOaFuRsJq9VJ
         3B7oKqfhKcO9j7iqf81fCEUJpmNjvEwwUgUNiv0nlKGrnGvptRr61qa9TAOhyfvctvkj
         UJU9zmjebIZjKdhoZiTofUd721cAhxhamTHUaimuEWoLDuzBwDPoBqXHJzcMjgToyM+m
         TW3M4v0Pxex3uDq7dzq4AS2GizN/vQOFSZKu5H1RbMl9yE+Cl+ijyWwExNshySKZlXo/
         /JvQ==
X-Gm-Message-State: ACgBeo3jNySbg3/dopLLwc+DuE3drgKIpCW568rvoaOHHvt/7VB/pQ23
        EnfyEkevN1qh5kS+J8CCL/qNeCzYWPZzsw==
X-Google-Smtp-Source: AA6agR6Bcj0oLQxUyIZFP+mybpbdTXmXXb/QsUX14+Srm6l6xiwUGWjiva4ZukgC8Y1yA23DDMaXgg==
X-Received: by 2002:a17:90a:bb15:b0:1f2:2a7d:7e05 with SMTP id u21-20020a17090abb1500b001f22a7d7e05mr2860213pjr.70.1659498659887;
        Tue, 02 Aug 2022 20:50:59 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b0016d33b8a231sm501911plh.270.2022.08.02.20.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 20:50:59 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 62C41103A1E; Wed,  3 Aug 2022 10:50:56 +0700 (WIB)
Date:   Wed, 3 Aug 2022 10:50:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 10/10] Documentation/x86: Update resctrl_ui.rst for
 new features
Message-ID: <YunwoDwcy7GZoKXA@debian.me>
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
 <165938740360.724959.7059659465268246182.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165938740360.724959.7059659465268246182.stgit@bmoger-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 03:56:43PM -0500, Babu Moger wrote:
> Update the documentation for the new features:
> 1. Slow Memory Bandwidth allocation.
>    With this feature, the QOS  enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
> 
> 2. Bandwidth Monitoring Event Configuration (BMEC).
>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not
>    enough to count all the different types are memory events. With the
>    feature BMEC, the users have the option to configure mbm_total_bytes
>    and mbm_local_bytes to count the specific type of events.
> 
> Added the instructions to configure with examples.
> 
Say "Also add configuration instructions with examples" instead.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst |  123 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..ba6833171c0a 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -167,6 +167,12 @@ with the following files:
>  		bytes) at which a previously used LLC_occupancy
>  		counter can be considered for re-use.
>  
> +"mon_configurable":
> +                Provides the information if the events mbm_total and
> +                mbm_local are configurable. See the configuration
> +                details for "mbm_total_config" and "mbm_local_config"
> +                for more information.
> +
>  Finally, in the top level of the "info" directory there is a file
>  named "last_cmd_status". This is reset with every "command" issued
>  via the file system (making new directories or writing to any of the
> @@ -264,6 +270,29 @@ When monitoring is enabled all MON groups will also contain:
>  	the sum for all tasks in the CTRL_MON group and all tasks in
>  	MON groups. Please see example section for more details on usage.
>  
> +"mbm_total_config":
> +"mbm_local_config":
> +        This contains the current event configuration for the events
> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
> +        These files are organized by L3 domains under the subdirectories
> +        "mon_L3_00" and "mon_L3_01". When BMEC is supported, the events
> +        mbm_local_bytes and mbm_total_bytes are configurable.
> +
> +        Following are the types of events supported.
> +        Bits    Description
> +        6       Dirty Victims from the QOS domain to all types of memory
> +        5       Reads to slow memory in the non-local NUMA domain
> +        4       Reads to slow memory in the local NUMA domain
> +        3       Non-temporal writes to non-local NUMA domain
> +        2       Non-temporal writes to local NUMA domain
> +        1       Reads to memory in the non-local NUMA domain
> +        0       Reads to memory in the local NUMA domain
> +

Why not use table?

> +        By default, the mbm_total_bytes configuration is set to 0x7f to count
> +        all the event types and the mbm_local_bytes configuration is set to
> +        0x15 to count all the local memory events.
> +
>  Resource allocation rules
>  -------------------------
>  
> @@ -464,6 +493,14 @@ Memory bandwidth domain is L3 cache.
>  
>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>  
> +Slow Memory bandwidth Allocation (when supported)
> +------------------------------------------
> +
> +Slow Memory b/w domain is L3 cache.
> +::
> +
> +	SB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
> +
>  Reading/writing the schemata file
>  ---------------------------------
>  Reading the schemata file will show the state of all resources
> @@ -479,6 +516,44 @@ which you wish to change.  E.g.
>    L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
>    L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>  
> +Reading/writing the schemata file (on AMD systems)
> +---------------------------------------------------------------
> +Reading the schemata file will show the state of all resources
> +on all domains. When writing the memory bandwidth allocation you
> +only need to specify those values in an absolute number expressed
> +in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
> +need to specify the value 16 (16 * 1/8 = 2).  E.g.
> +::
> +
> +  # cat schemata
> +    MB:0=2048;1=2048;2=2048;3=2048
> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
> +  # echo "MB:1=16" > schemata
> +  # cat schemata
> +    MB:0=2048;1=  16;2=2048;3=2048
> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
> +Reading/writing the schemata file (on AMD systems) with slow memory
> +---------------------------------------------------------------
> +Reading the schemata file will show the state of all resources
> +on all domains. When writing the memory bandwidth allocation you
> +only need to specify those values in an absolute number expressed
> +in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
> +need to specify the value 64 (64 * 1/8 = 8).  E.g.
> +::
> +
> +  # cat schemata
> +    SB:0=2048;1=2048;2=2048;3=2048
> +    MB:0=2048;1=2048;2=2048;3=2048
> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
> +  # echo "SB:1=64" > schemata
> +  # cat schemata
> +    SB:0=2048;1=  64;2=2048;3=2048
> +    MB:0=2048;1=2048;2=2048;3=2048
> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
>  Cache Pseudo-Locking
>  ====================
>  CAT enables a user to specify the amount of cache space that an
> @@ -1210,6 +1285,54 @@ View the llc occupancy snapshot::
>    # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
>    11234000
>  
> +Example 5 (Configure and Monitor specific event types)
> +-------------------------------------------------
> +
> +A single socket system which has real time tasks running on cores 0-4
> +and non real time tasks on other CPUs. We want to monitor the memory
> +bandwidth allocation for specific events.
> +::
> +
> +  # mount -t resctrl resctrl /sys/fs/resctrl
> +  # cd /sys/fs/resctrl
> +  # mkdir p1
> +
> +Move the CPUs 0-4 over to p1::
> +
> +  # echo 0xf > p1/cpus
> +
> +View the current mbm_local_bytes::
> +
> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_bytes
> +  112501
> +
> +Change the mbm_local_bytes to count mon-temporal writes to both local
> +and non-local NUMA domain. Refer to event supported bitmap under
> +mbm_local_config::
> +
> +  # echo 0xc > /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_config
> +
> +View the updated mbm_local_bytes::
> +
> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_bytes
> +  12601
> +
> +Similar experiment on mbm_total_bytes. First view the current mbm_total_bytes::
> +
> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_bytes
> +  1532501
> +
> +Change the mbm_total_bytes to count only reads to slow memory on both local
> +and non-local NUMA domain. Refer to event supported bitmap under
> +mbm_total_config::
> +
> +  # echo 0x30 > /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_config
> +
> +View the updated mbm_total_bytes::
> +
> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_bytes
> +  104562
> +
>  Intel RDT Errata
>  ================
>  
> 
> 

When building this documentation, I get new warnings:

Documentation/x86/resctrl.rst:275: WARNING: Unexpected indentation.
Documentation/x86/resctrl.rst:497: WARNING: Title underline too short.

Slow Memory bandwidth Allocation (when supported)
------------------------------------------
Documentation/x86/resctrl.rst:497: WARNING: Title underline too short.

Slow Memory bandwidth Allocation (when supported)
------------------------------------------
Documentation/x86/resctrl.rst:538: WARNING: Title underline too short.

Reading/writing the schemata file (on AMD systems) with slow memory
---------------------------------------------------------------
Documentation/x86/resctrl.rst:538: WARNING: Title underline too short.

Reading/writing the schemata file (on AMD systems) with slow memory
---------------------------------------------------------------
Documentation/x86/resctrl.rst:1289: WARNING: Title underline too short.

Example 5 (Configure and Monitor specific event types)
-------------------------------------------------
Documentation/x86/resctrl.rst:1289: WARNING: Title underline too short.

Example 5 (Configure and Monitor specific event types)
-------------------------------------------------

I have to apply the fixup:

---- >8 ----

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index ba6833171c0a39..886cb9bd7a181c 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -270,8 +270,7 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
-"mbm_total_config":
-"mbm_local_config":
+"mbm_total_config", "mbm_local_config":
         This contains the current event configuration for the events
         mbm_total_bytes and mbm_local_bytes, respectively, when the
         Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
@@ -279,8 +278,11 @@ When monitoring is enabled all MON groups will also contain:
         "mon_L3_00" and "mon_L3_01". When BMEC is supported, the events
         mbm_local_bytes and mbm_total_bytes are configurable.
 
-        Following are the types of events supported.
+        Following are the types of events supported:
+
+        ====    ========================================================
         Bits    Description
+        ====    ========================================================
         6       Dirty Victims from the QOS domain to all types of memory
         5       Reads to slow memory in the non-local NUMA domain
         4       Reads to slow memory in the local NUMA domain
@@ -288,6 +290,7 @@ When monitoring is enabled all MON groups will also contain:
         2       Non-temporal writes to local NUMA domain
         1       Reads to memory in the non-local NUMA domain
         0       Reads to memory in the local NUMA domain
+        ====    ========================================================
 
         By default, the mbm_total_bytes configuration is set to 0x7f to count
         all the event types and the mbm_local_bytes configuration is set to
@@ -494,7 +497,7 @@ Memory bandwidth domain is L3 cache.
 	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
 
 Slow Memory bandwidth Allocation (when supported)
-------------------------------------------
+-------------------------------------------------
 
 Slow Memory b/w domain is L3 cache.
 ::
@@ -517,7 +520,7 @@ which you wish to change.  E.g.
   L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
 Reading/writing the schemata file (on AMD systems)
----------------------------------------------------------------
+--------------------------------------------------
 Reading the schemata file will show the state of all resources
 on all domains. When writing the memory bandwidth allocation you
 only need to specify those values in an absolute number expressed
@@ -535,7 +538,7 @@ need to specify the value 16 (16 * 1/8 = 2).  E.g.
     L3:0=ffff;1=ffff;2=ffff;3=ffff
 
 Reading/writing the schemata file (on AMD systems) with slow memory
----------------------------------------------------------------
+-------------------------------------------------------------------
 Reading the schemata file will show the state of all resources
 on all domains. When writing the memory bandwidth allocation you
 only need to specify those values in an absolute number expressed
@@ -1286,7 +1289,7 @@ View the llc occupancy snapshot::
   11234000
 
 Example 5 (Configure and Monitor specific event types)
--------------------------------------------------
+------------------------------------------------------
 
 A single socket system which has real time tasks running on cores 0-4
 and non real time tasks on other CPUs. We want to monitor the memory

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
