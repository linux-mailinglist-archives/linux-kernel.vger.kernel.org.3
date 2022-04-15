Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1A502EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbiDOSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243489AbiDOSSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:18:17 -0400
Received: from pi3.com.pl (pi3.com.pl [185.238.74.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F04B41A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:15:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 3C1F24C0436;
        Fri, 15 Apr 2022 20:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650046048; bh=zLysKOD7SEPDfDn1t54Xs5F15NmXU5k3wNqVbtBerHI=;
        h=Date:From:To:Subject:From;
        b=Pmlsxxf07GUXIZo7ET1/wXHU/7cpf+LnmelB4mV9w/nZvVR9a3RQ/Zo5eopYwk7RJ
         +T581GqsI7+PEOLOOMgYRSSZ1gEwVbKQHlnpNsrRg+SQSKBCAcNPGGN0P8aYTVs1fD
         Nc2+BExgbZCQcslypwHsJN6ADimFt1PHyqpxZ6b5v7fbodtG15If/28CaR/eg53HjC
         fKZI/jAvi2HGnF8AgKamu79hOy42xEpvu6ot+5Mxt99PA+fkTGqlByiv5XZTDy8g/B
         C+l3euDF4gjVUIWLlQ0sLXa0GczCxoniDmnLCXPhw6AVBCaORyt1hFFUSHhTMrBQgr
         0+Y1QO/m9vfpg==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yGxsOm2WkxrC; Fri, 15 Apr 2022 20:07:23 +0200 (CEST)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id D91204C1566; Fri, 15 Apr 2022 20:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650046043; bh=zLysKOD7SEPDfDn1t54Xs5F15NmXU5k3wNqVbtBerHI=;
        h=Date:From:To:Subject:From;
        b=hSm9Xinf3ljrsjHcccmjqm1Yvnu8PA0SD1hjcEZ1B0IVlGjXQEyWC3VhNv6PQVfvG
         1MW4OBDK5aWDW+BRnAIJ5qvkBrcq1Oa9myYcHc68nQoxiBFdedWX8ypn7JvsgEKcaX
         aV0CPnfe2+CBADTaRAfmcYTCZmJaCepR+3aUxuebnfW5owat35nl32VeJ5sQIBPxlJ
         INJgKIYVGIXmfuxKeCmvFWY5UgH2qCoNoY770t0t/o2Is7TlCQqg3NRV0e2+OuzkG1
         Xmg8/QfmVWsknNPwZ8Y87e0G/WMrPPxpr+Euz26WQiU28PYopyZ5YVYOBHLrECi/a+
         4rJm7ntlyjlfQ==
Date:   Fri, 15 Apr 2022 20:07:23 +0200
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: KRETPROBES are broken since the commit 73f9b911faa7
Message-ID: <20220415180723.GA13921@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The recent KRETPROBE kernel changes introduced a potential NULL pointer
dereference bug when return handler is not set. The root of the problem
are the following commits related to "kprobes: Use rethook for kretprobe
if possible":
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3a112c0c40dd96d53c8bdf3ea8d94d528f3b7b8
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73f9b911faa74ac5107879de05c9489c419f41bb


When user sets up a KRETPROBE, kernel eventually ends up here:

static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
                      struct pt_regs *regs)
{
    struct kretprobe *rp = (struct kretprobe *)data;
    struct kretprobe_instance *ri;
    struct kprobe_ctlblk *kcb;

    /* The data must NOT be null. This means rethook data structure is broken. */
    if (WARN_ON_ONCE(!data))
        return;

    __this_cpu_write(current_kprobe, &rp->kp);
    kcb = get_kprobe_ctlblk();
    kcb->kprobe_status = KPROBE_HIT_ACTIVE;

    ri = container_of(rh, struct kretprobe_instance, node);
    rp->handler(ri, regs);

    __this_cpu_write(current_kprobe, NULL);
}
NOKPROBE_SYMBOL(kretprobe_rethook_handler);

Unfortunately, rp->handler is not verified against NULL. If user does not
set up a return handler, KRETPROBE shouldn't call it (that's the defined
behavior in the documentation, quoting "Any or all handlers can be NULL").
However, kretprobe_rethook_handler function does not enforce such behavior.

I'm going to send a patch for it in a reply to this message.

Thanks,
Adam

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

