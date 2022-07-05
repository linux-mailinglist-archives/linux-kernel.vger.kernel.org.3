Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1115673A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiGEP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiGEP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:57:45 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0872E1164
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:57:44 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 265Fmsn6029167;
        Tue, 5 Jul 2022 10:48:55 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 265FmqXx029161;
        Tue, 5 Jul 2022 10:48:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 5 Jul 2022 10:48:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
        Sathvika Vasireddy <sv@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Message-ID: <20220705154852.GR25951@gate.crashing.org>
References: <20220624183238.388144-1-sv@linux.ibm.com> <20220624183238.388144-12-sv@linux.ibm.com> <70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu> <92eae2ef-f9b6-019a-5a8e-728cdd9bbbc0@linux.vnet.ibm.com> <cce19b1c-449a-f306-533a-9edc855049aa@csgroup.eu> <YsLS02T6TAxN/HcL@hirez.programming.kicks-ass.net> <6ab46ef2-6bbd-e758-a7ff-5f62fdf1ca96@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ab46ef2-6bbd-e758-a7ff-5f62fdf1ca96@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 12:34:08PM +0000, Christophe Leroy wrote:
> Le 04/07/2022 à 13:45, Peter Zijlstra a écrit :
> > I'm somewhat confused; how is an empty STT_FUNC a valid construct on
> > Power?
> 
> So am I. It is likely not a valid construct, but that's what GCC seems 
> to generate when you call annotate_unreachable().

It is a valid construct on (almost) all targets.  If the user chooses to
have executable code terminate in limbo, that is what the compiler will
do (and this can result in a code symbol with size 0).  Compare this to
data symbols with no size, the situation is quite similar.


Segher
