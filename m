Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB751FC7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiEIMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiEIMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:20:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E02253E;
        Mon,  9 May 2022 05:16:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652098584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJHxy69CHJC0fW0RUic58UUaRLbHK6HeLX4XWrP5DrY=;
        b=pgzvbJOQH8lej+TkKOsMSFhJRMJMColPNkYzFZVBBlpf/46dIROYO5vORg8k2Vf0rtSl15
        yL21hz9LihhpHVhcQNphshrsealyrBUoDu1O7vgwgxK2ZO+heHUCuDNQkbK8lwbUsYVJrV
        qqXkQ2xjnw+2c+CM6LMfuekiUILP6Esh45CmKwL6Le+ajHzF3vWukaITypPKTSv83oUvKj
        CDeTrXxADtlbITbhv7GnQ+PO8+g/5xqNcPoM3CZWX+9QdUaYPcdx1TiUKEFyY55BQwXcI/
        noTVMEUWz2Z3maEOy8hcYHAL9e7d+JtH59Ii2eINADAPcsx/eXO6C5fEzTodeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652098584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJHxy69CHJC0fW0RUic58UUaRLbHK6HeLX4XWrP5DrY=;
        b=wNbjnljwg8nS7pLu+J1h+4gw/qT50N9VyINHaSbRy43iV2OtX9W+UKOUwZW6rx0dyuRNcY
        JCj5N7vE0W7rdCAQ==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v7 12/12] Documentation: In-Field Scan
In-Reply-To: <20220506225410.1652287-13-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
 <20220506225410.1652287-13-tony.luck@intel.com>
Date:   Mon, 09 May 2022 14:16:23 +0200
Message-ID: <87pmkmrje0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06 2022 at 15:54, Tony Luck wrote:
> Add documentation for In-Field Scan (IFS). This documentation
> describes the basics of IFS, the loading IFS image, chunk
> authentication, running scan and how to check result via sysfs.
>
> The CORE_CAPABILITIES MSR enumerates whether IFS is supported.
>
> The full  github location for distributing the IFS images is
> still being decided. So just a placeholder included for now
> in the documentation.
>
> Future CPUs will support more than one type of test. Plan for
> that now by using a "_0" suffix on the ABI directory names.
> Additional test types will use "_1", etc.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
