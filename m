Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5946456D32C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGKDDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKDDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:03:47 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C035AE60
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 20:03:45 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220711030342epoutp0371d4709fd29293e7b88223b436967073~Ap098w6wo0708107081epoutp03O
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:03:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220711030342epoutp0371d4709fd29293e7b88223b436967073~Ap098w6wo0708107081epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657508622;
        bh=PNUfvCy84e9Zz5Ld9SjN2TCbZtJ0xMlSlgGfnADVN8g=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=RZW3Bb7buM/OpH18Irc5d+uSlEkX1ZGH/+TnHq4XzmMFn1VEpjx3/uWXjKDFFJ5HR
         TJI/qCTqnNS6NZfPyIDahv8qHdE4kqmjRRqka0jOm2/up4VgbN/QAI877lL+YFMdxJ
         cp7VJRLfvl1ExR5ddwuP/9TyLQeU6Wwb9S//zi9M=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220711030342epcas5p3fda6d270c80a177a7c43ea2f7190ab37~Ap09cfris1855918559epcas5p3V;
        Mon, 11 Jul 2022 03:03:42 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-36-62cb930e7df4
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.44.09639.E039BC26; Mon, 11 Jul 2022 12:03:42 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] sched,debug: fix dentry leak in update_sched_domain_debugfs
Reply-To: major.chen@samsung.com
Sender: Major Chen <major.chen@samsung.com>
From:   Major Chen <major.chen@samsung.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>
CC:     Hongfei Tang <hongfei.tang@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a@epcms5p1>
Date:   Mon, 11 Jul 2022 11:03:41 +0800
X-CMS-MailID: 20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmpi7f5NNJBv9fsVpcenyVzWL6y0YW
        i6cTtjJbbOpvZLS42z+VxeLyrjlsFpPfPWO0uHRgAZPF8d4DTBb7Oh4wWXQc+cbswO2xZt4a
        Ro+WfbfYPRZsKvXYvELL4861PWwe7/ddZfPo27KK0WPz6WqPz5vkAjijuGxSUnMyy1KL9O0S
        uDLm9XxkL7grXnH7wHTGBsZe8S5GTg4JAROJnff2s3QxcnEICexmlOh4f5Wxi5GDg1dAUOLv
        DmGQGmEBH4nm9k52EFtIQEFiwqkuNoi4tsSfTc9ZQMrZBDQlzm6qBBkjIrCeWeL8keNMIDXM
        AjkSfefXsELs4pWY0f6UBcKWlti+fCsjhC0qcXP1W3YY+/2x+VBxEYnWe2eZIWxBiQc/d0PF
        pSSuH//NBGEXS9x8fBdqZgOjRP8ZGQjbXOLrph6wel4BX4lfL6eBzWERUJVovLgGapeLxMJZ
        F5kh7tSWWLbwNTPIL8xAv6zfpQ8R5pPo/f2ECeb8HfNgbBWJ1t1T2GDOub1+IytIq4SAh8SC
        RbqQkAqUuDF7BcsERrlZiPCchWTXLIRdCxiZVzFKphYU56anFpsWGOellusVJ+YWl+al6yXn
        525iBCcfLe8djI8efNA7xMjEwXiIUYKDWUmE98/ZU0lCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eb2ubkoSEkhPLEnNTk0tSC2CyTJxcEo1MG17nyQw173494+vl2eKvW+dxxa4ruTghshz06Qs
        WW+GnM/YeDKvX81nzuTIzy2H9vKzTl5zc6G/36eqyG1vz7eumsDGt1x1a8AUzbV3xJOnxz0t
        7/9xfgf/tYcJHVoXxXcJ5YclB3+9ZlQTVuBcYpN8N3b1jtuabv8m7HgT7j1XavUijbT447Yp
        cnIrr3zdtbZDMcGTRdDeRPLaFTFu/1s7D+y7ePd9U6v5g/+CtjOWhGhXtZmxX/NmDT0U+O+N
        6ba4ev9oyy+zr1zsZJpq/fE9/63G2m3MBYkbPRNnKjAvn7bdc6fwm1xfuYUP3swsSbKI3Z8l
        M2PxfeYTZgYOyrxS92UdmrSXbS+S2lFz/o0SS3FGoqEWc1FxIgDAi6yyrQMAAA==
X-CMS-RootMailID: 20220711025311epcms5p874ccee18b6dd4e6a62759d0749936e61
References: <CGME20220711025311epcms5p874ccee18b6dd4e6a62759d0749936e61@epcms5p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C2=A0=0D=0Aupdate_sched_domain_debugfs()=C2=A0uses=C2=A0debugfs_lookup()=
=C2=A0to=C2=A0find=C2=A0wanted=C2=A0dentry(which=C2=A0has=0D=0Abeen=C2=A0cr=
eated=C2=A0by=C2=A0debugfs_create_dir()=C2=A0before),=C2=A0but=C2=A0not=C2=
=A0call=C2=A0dput()=C2=A0to=C2=A0return=C2=A0this=C2=A0dentry=0D=0Aback.=C2=
=A0This=C2=A0result=C2=A0in=C2=A0dentry=C2=A0leak=C2=A0even=C2=A0debugfs_re=
move()=C2=A0is=C2=A0called.=0D=0A=C2=A0=0D=0ASigned-off-by:=C2=A0major.chen=
=C2=A0<major.chen=40samsung.com>=0D=0A---=0D=0A=C2=A0kernel/sched/debug.c=
=C2=A0=7C=C2=A07=C2=A0+++++--=0D=0A=C2=A01=C2=A0file=C2=A0changed,=C2=A05=
=C2=A0insertions(+),=C2=A02=C2=A0deletions(-)=0D=0A=C2=A0=0D=0Adiff=C2=A0--=
git=C2=A0a/kernel/sched/debug.c=C2=A0b/kernel/sched/debug.c=0D=0Aindex=C2=
=A0bb3d63b..4ffea2d=C2=A0100644=0D=0A---=C2=A0a/kernel/sched/debug.c=0D=0A+=
++=C2=A0b/kernel/sched/debug.c=0D=0A=40=40=C2=A0-412,11=C2=A0+412,14=C2=A0=
=40=40=C2=A0void=C2=A0update_sched_domain_debugfs(void)=0D=0A=C2=A0=0D=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_cpu(cpu,=C2=
=A0sd_sysctl_cpus)=C2=A0=7B=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0sch=
ed_domain=C2=A0*sd;=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0dentry=C2=A0*d_=
cpu;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0dentry=C2=A0*d_cpu,=C2=A0*d_lo=
okup;=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char=C2=A0buf=5B32=5D;=0D=0A=C2=A0=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(buf,=C2=A0sizeof(buf),=C2=A0=22cp=
u%d=22,=C2=A0cpu);=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debugfs_remove(debugfs_look=
up(buf,=C2=A0sd_dentry));=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0d_lookup=C2=A0=3D=C2=
=A0debugfs_lookup(buf,=C2=A0sd_dentry);=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debugf=
s_remove(d_lookup);=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21IS_ERR_OR_NULL(=
d_lookup))=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0dput(d_lookup);=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0d_cpu=C2=A0=3D=
=C2=A0debugfs_create_dir(buf,=C2=A0sd_dentry);=0D=0A=C2=A0=0D=0A=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0i=C2=A0=3D=C2=A00;=0D=0A--=C2=A0=0D=0A2.7.4=0D=0A=C2=A0=
=0D=0A=C2=A0=0D=0A=0D=0A
