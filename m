Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145835A3C10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiH1GAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiH1GA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:00:29 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FF11A21;
        Sat, 27 Aug 2022 23:00:27 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27S606Pj000431;
        Sun, 28 Aug 2022 15:00:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 28 Aug 2022 15:00:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27S605D8000428
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 28 Aug 2022 15:00:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <046968f7-3245-1df5-6e11-6f29292bbbc5@I-love.SAKURA.ne.jp>
Date:   Sun, 28 Aug 2022 15:00:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [Question] iforce_serio lockup
Content-Language: en-US
To:     Greg Tulli <greg.iforce@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <CAKEH-64YKTnb444AZsgm0MudN=KMM_EWv8SsNUwZGh9OGm4ayA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAKEH-64YKTnb444AZsgm0MudN=KMM_EWv8SsNUwZGh9OGm4ayA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/30 4:24, Greg Tulli wrote:
> I was advised to use a vanilla kernel with CONFIG_PROVE_LOCKING and
> decode the symbols in the report. So I followed
> https://kernelnewbies.org/OutreachyfirstpatchSetup and here's the
> result. Thanks, Tetsuo Handa.
> 
> WARNING: possible circular locking dependency detected
> 5.19.0-rc6iforce-00194-gf3a76018dd55 #2 Not tainted

OK. You confirmed that this is a real deadlock.

> 2022-07-11 11:32 GMT+02:00, Greg T <greg.iforce@gmail.com>:
> 
>> That problem vanishes if we don't call iforce_process_packet directly
>> from iforce_serio_irq, but from a tasklet. Is that a right approach?

Does untested diff shown below solve the problem?
I don't know about flush ordering in iforce_serio_disconnect().

 drivers/input/joystick/iforce/iforce-serio.c | 51 +++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index f95a81b9fac7..5ff650ce05ab 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -124,8 +124,7 @@ static void iforce_serio_write_wakeup(struct serio *serio)
 	iforce_serio_xmit(iforce);
 }
 
-static irqreturn_t iforce_serio_irq(struct serio *serio,
-				    unsigned char data, unsigned int flags)
+static void do_iforce_serio(struct serio *serio, unsigned char data)
 {
 	struct iforce_serio *iforce_serio = serio_get_drvdata(serio);
 	struct iforce *iforce = &iforce_serio->iforce;
@@ -183,6 +182,53 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 		iforce_serio->csum = 0;
 	}
 out:
+	return;
+}
+
+struct iforce_serio_irq {
+	struct list_head list;
+	struct serio *serio;
+	unsigned char data;
+};
+static LIST_HEAD(iforce_serio_irq_list);
+static DEFINE_SPINLOCK(iforce_serio_irq_list_lock);
+
+static void iforce_serio_workfn(struct work_struct *work)
+{
+	static DEFINE_MUTEX(lock);
+	struct iforce_serio_irq *ev;
+
+	mutex_lock(&lock);
+	spin_lock_irq(&iforce_serio_irq_list_lock);
+	while (!list_empty(&iforce_serio_irq_list)) {
+		ev = list_first_entry(&iforce_serio_irq_list, struct iforce_serio_irq, list);
+		list_del(&ev->list);
+		spin_unlock_irq(&iforce_serio_irq_list_lock);
+		do_iforce_serio(ev->serio, ev->data);
+		kfree(ev);
+		spin_lock_irq(&iforce_serio_irq_list_lock);
+	}
+	spin_unlock_irq(&iforce_serio_irq_list_lock);
+	mutex_unlock(&lock);
+}
+static DECLARE_WORK(iforce_serio_work, iforce_serio_workfn);
+
+static irqreturn_t iforce_serio_irq(struct serio *serio,
+				    unsigned char data, unsigned int flags)
+{
+	bool was_empty;
+	struct iforce_serio_irq *ev = kmalloc(sizeof(*ev), GFP_ATOMIC | __GFP_NOWARN);
+
+	if (ev) {
+		ev->serio = serio;
+		ev->data = data;
+		spin_lock(&iforce_serio_irq_list_lock);
+		was_empty = list_empty(&iforce_serio_irq_list);
+		list_add_tail(&ev->list, &iforce_serio_irq_list);
+		spin_unlock(&iforce_serio_irq_list_lock);
+		if (was_empty)
+			queue_work(system_highpri_wq, &iforce_serio_work);
+	}
 	return IRQ_HANDLED;
 }
 
@@ -220,6 +266,7 @@ static void iforce_serio_disconnect(struct serio *serio)
 {
 	struct iforce_serio *iforce_serio = serio_get_drvdata(serio);
 
+	flush_work(&iforce_serio_work);
 	input_unregister_device(iforce_serio->iforce.dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
-- 
2.18.4

