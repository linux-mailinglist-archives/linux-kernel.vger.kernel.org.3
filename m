Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4E51B794
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbiEEFt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbiEEFt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:49:27 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AE76377D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651729548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OB2SJWAbhkv+kJ54v7gaAtBueD1ceTwg1RbEyJ/vO0=;
        b=Nz7y+McGhxPhJLW91mNW8TlE+oSTbqpJjVfrBGLjXjouG/s0EZPpAYDgD3F4PfoWCI4Yce
        CvU7Uw/85mD72eidLC+7tI3YFeB/X7DCX0xwHcJT4YEkxnX0Ybjru3w9tR5r6e3s+GK+F6
        Xph8fya7AtQhVD/P1jCUkpMuxK5lf08=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-397aCiWfNlG4en0fd6A3IQ-1; Thu, 05 May 2022 01:45:43 -0400
X-MC-Unique: 397aCiWfNlG4en0fd6A3IQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52FC629ABA2F;
        Thu,  5 May 2022 05:45:42 +0000 (UTC)
Received: from localhost (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A35CC15E71;
        Thu,  5 May 2022 05:45:41 +0000 (UTC)
Date:   Thu, 5 May 2022 13:45:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <YnNkgfnHlUTky0lt@MiWiFi-R3L-srv>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
 <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
 <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
 <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/22 at 10:48am, Sourabh Jain wrote:
> Hi Baoquan,
> 
> On 26/04/22 10:52, Baoquan He wrote:
> > On 04/26/22 at 09:36am, Sourabh Jain wrote:
> > > On 15/04/22 03:59, Eric DeVolder wrote:
......

> > > > > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > > > > +static int crash_memhp_notifier(struct notifier_block *nb,
> > > > > > +    unsigned long val, void *v)
> > > > > > +{
> > > > > > +    struct memory_notify *mhp = v;
> > > > > > +
> > > > > > +    switch (val) {
> > > > > > +    case MEM_ONLINE:
> > > > > > +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
> > > > > We don't differentiate the memory add/remove, cpu add, except of cpu
> > > > > remove. Means the hp_action only differentiate cpu remove from the other
> > > > > action. Maybe only making two types?
> > > > > 
> > > > > #define KEXEC_CRASH_HP_REMOVE_CPU   0
> > > > > #define KEXEC_CRASH_HP_UPDATE_OTHER      1
> > > > > 
> > > > Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
> > > > ADD_MEMORY.
> > > > Do you still want to consolidate these?
> > > On PowerPC different actions are needed for CPU add and memory add/remove.
> > > For CPU add case only FDT is updated whereas for the memory hotplug we will
> > > be
> > > updating FDT and elfcorehdr.
> > I don't understand. For elfcorehdr updating, we only need regenerate it.
> > Do you update them different for memory add/remove?
> 
> We have different actions for cpu remove, CPU add and memory add/remove
> case.
> 
> CPU remove: no action
> CPU add: update flattened device tree (FDT)
> memory add/remove: update FDT and regenerate/update elfcorehdr
> 
> Since memory add/remove action is same we can have common hp_action for
> them.

For memory hot add/remove, we need rengereate elfcorehdr, and add the
new elfcorehdr into fdt. Except of this, FDT need to know the hp_action
and the hot added/removed memory region, namely the start and end, e.g
[start, end]? 

I checked arm64 kexec code, seems we only need to know if mem hotplug
event happened, then regenerate elfcorehdr and embed the new elfcorehdr
into fdt. Then we don't know pass the [start, end] info into the
handler. Please tell if ppc is different or I missed anything.

If I am right, I would like the handler interface as Boris has made
in his draft patch.

void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
                                           unsigned int cpu)

static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> 
> > 
> > What I saw is the added action for memory hotplug is only for message
> > printing. Is this really needed? And memory hotplug is even not
> > supported. Please correct me if I missed anything.
> 
> I agree that currently memory hp_action is only used for printing warning
> message but
> eventually we will be handling memory hotplug case as well.
> 
> > +       /* crash update on memory hotplug is not support yet */
> > +       if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
> > +               pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
> > +               return;
> > +       }
> 
> Thanks,
> Sourabh Jain
> 

