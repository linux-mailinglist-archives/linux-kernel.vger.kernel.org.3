Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A044E1F04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiCUC2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbiCUC2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:28:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77324F1C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:27:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMJR96tdqz4xNq;
        Mon, 21 Mar 2022 13:27:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1647829624;
        bh=plT1NW/VqseH3wHAwgIVBIsiL7RgCuaBdXW+C0sq1G0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ks1WQ/qH0TiFfwdBMd6XOBIfocUU+W0THd6+RZShvKVkOlxyZThigOOqPXWsj+8hr
         fZ6vlAlxihi6Jno6c2bUABJ3b6LJs2LgH1XzntjPKJQCj45VD55FG5xtfbQxJdAe/y
         ygeEHPkgOX5AJbN5FDMXsHgLQ5XTjmUofwu5bGwIl5PDoyhKAUE4BrVBm6Z6aehkFq
         oNofUroPZqFBak8c7VI7j7305dWe0ns78jGYwxduUBGsX2aVJ1HiS/hB5FTdjjDPFX
         qXXX5CXph6ecW1HNTPfnMBCtzj2xrevc9rRGOjDlm77t3w9UD7xWZ3+x8PvX+7g0I4
         4xIONzBqvAW+g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
In-Reply-To: <33447256-81d1-8844-d82f-e8ac94f65fbe@csgroup.eu>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <33447256-81d1-8844-d82f-e8ac94f65fbe@csgroup.eu>
Date:   Mon, 21 Mar 2022 13:27:01 +1100
Message-ID: <87pmmgghvu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 18/03/2022 =C3=A0 13:26, Peter Zijlstra a =C3=A9crit=C2=A0:
>> On Fri, Mar 18, 2022 at 04:21:40PM +0530, Sathvika Vasireddy wrote:
>>> This patch adds powerpc specific functions required for
>>> 'objtool mcount' to work, and enables mcount for ppc.
>>=20
>> I would love to see more objtool enablement for Power :-)
>
> I have not received this series and I can't see it on powerpc patchwork=20
> either (https://patchwork.ozlabs.org/project/linuxppc-dev/list/)
>
> Did you send it to linuxppc-dev list ? If not can you resend it there ?

It is there, might have been delayed?

http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D291129

There are some CI failures.

cheers
